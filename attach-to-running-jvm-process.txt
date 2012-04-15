# Attach to running JVM process

External program like jstack, jmap, jhat can attach to running JVM process using pid of the JVM.
In linux, the communication is done via local socket, the JVM create and listen on local socket
with filename .java_pid<pid> in current dir "/proc/<pid>/cwd" or "/tmp"

**The attaching program**

The attaching program looks for socket file and if not found try to kickoff Attach Listener Thread of JVM by
sending a QUIT signal to the relevant thread that has installed the signal's handlers.

    #./sun/tools/attach/LinuxVirtualMachine.java

    LinuxVirtualMachine(AttachProvider provider, String vmid)
        throws AttachNotSupportedException, IOException
    {
        super(provider, vmid);

        // This provider only understands pids
        int pid;
        try {
            pid = Integer.parseInt(vmid);
        } catch (NumberFormatException x) {
            throw new AttachNotSupportedException("Invalid process identifier");
        }

        // Find the socket file. If not found then we attempt to start the
        // attach mechanism in the target VM by sending it a QUIT signal.
        // Then we attempt to find the socket file again.
        path = findSocketFile(pid);
        if (path == null) {
            File f = createAttachFile(pid);
            try {
                // On LinuxThreads each thread is a process and we don't have the
                // pid of the VMThread which has SIGQUIT unblocked. To workaround
                // this we get the pid of the "manager thread" that is created
                // by the first call to pthread_create. This is parent of all
                // threads (except the initial thread).
                if (isLinuxThreads) {
                    int mpid;
                    try {
                        mpid = getLinuxThreadsManager(pid);
                    } catch (IOException x) {
                        throw new AttachNotSupportedException(x.getMessage());
                    }
                    assert(mpid >= 1);
                    sendQuitToChildrenOf(mpid);
                } else {
                    sendQuitTo(pid);
                }

                // give the target VM time to start the attach mechanism
                int i = 0;
                long delay = 200;
                int retries = (int)(attachTimeout() / delay);
                do {
                    try {
                        Thread.sleep(delay);
                    } catch (InterruptedException x) { }
                    path = findSocketFile(pid);
                    i++;
                } while (i <= retries && path == null);
                if (path == null) {
                    throw new AttachNotSupportedException(
                        "Unable to open socket file: target process not responding " +
                        "or HotSpot VM not loaded");
                }
            } finally {
                f.delete();
            }
        }



        #sun/tools/attach/LinuxVirtualMachine.java
        
            InputStream execute(String cmd, Object ... args) throws AgentLoadException, IOException {
                assert args.length <= 3;                // includes null
        
                // did we detach?
                String p;
                synchronized (this) {
                    if (this.path == null) {
                        throw new IOException("Detached from target VM");
                    }
                    p = this.path;
                }
        
                // create UNIX socket
                int s = socket();
        
                // connect to target VM
                try {
                    connect(s, p);
                } catch (IOException x) {
                    close(s);
                    throw x;
                }
        
                IOException ioe = null;
        
                // connected - write request
                // <ver> <cmd> <args...>
                try {
                    writeString(s, PROTOCOL_VERSION);
                    writeString(s, cmd);
        
                    for (int i=0; i<3; i++) {
                        if (i < args.length && args[i] != null) {
                            writeString(s, (String)args[i]);
                        } else {
                            writeString(s, "");
                        }
                    }
                } catch (IOException x) {
                    ioe = x;
                }
        
        
                // Create an input stream to read reply
                SocketInputStream sis = new SocketInputStream(s);
        
                // Read the command completion status
                int completionStatus;
                try {
                    completionStatus = readInt(sis);
                } catch (IOException x) {
                    sis.close();
                    if (ioe != null) {
                        throw ioe;
                    } else {
                        throw x;
                    }
                }
        
                if (completionStatus != 0) {
                    sis.close();
        
                    // In the event of a protocol mismatch then the target VM
                    // returns a known error so that we can throw a reasonable
                    // error.
                    if (completionStatus == ATTACH_ERROR_BADVERSION) {
                        throw new IOException("Protocol mismatch with target VM");
                    }
        
                    // Special-case the "load" command so that the right exception is
                    // thrown.
                    if (cmd.equals("load")) {
                        throw new AgentLoadException("Failed to load agent library");
                    } else {
                        throw new IOException("Command failed in target VM");
                    }
                }
        
                // Return the input stream so that the command output can be read
                return sis;
            }


**The JVM**

There is Attach Listener Thread of JVM which is either starts when JVM starts or is kicked off by signal QUIT/BREAK.
The Attach Listner Thead is reponsible for create the UNIX server socket and listen for incomming operations from the socket.

        #src/os/linux/vm/attachListener_linux.cpp

        int LinuxAttachListener::init() {
        ... 
          int n = snprintf(path, UNIX_PATH_MAX, "%s/.java_pid%d",
                           os::get_temp_directory(), os::current_process_id());
        ... 
          // create the listener socket
          listener = ::socket(PF_UNIX, SOCK_STREAM, 0);
        ... 
          addr.sun_family = AF_UNIX;
          int res = ::bind(listener, (struct sockaddr*)&addr, sizeof(addr));
        ...
          return 0;
        }
     
        #os/linux/vm/attachListener_linux.cpp
        int AttachListener::pd_init() {
        ... 
          int ret_code = LinuxAttachListener::init();
        ...
          return ret_code;
        }
        
        #os/linux/vm/attachListener_linux.cpp
        bool AttachListener::is_init_trigger() {
        ...
            if (st.st_uid == geteuid()) {
              init();
              return true;
            }
        ...
          return false;
        }

        #share/vm/services/attachListener.cpp

        static void attach_listener_thread_entry(JavaThread* thread, TRAPS) {
          os::set_priority(thread, NearMaxPriority);
        
          if (AttachListener::pd_init() != 0) {
            return;
          }
          AttachListener::set_initialized();


        #share/vm/services/attachListener.cpp
        void AttachListener::init() {
        ... 
          { MutexLocker mu(Threads_lock);
            JavaThread* listener_thread = new JavaThread(&attach_listener_thread_entry);
        

        #share/vm/runtime/thread.cpp
        
        jint Threads::create_vm(JavaVMInitArgs* args, bool* canTryAgain) {
        ...
          // Start Attach Listener if +StartAttachListener or it can't be started lazily
          if (!DisableAttachMechanism) {
            if (StartAttachListener || AttachListener::init_at_startup()) {
              AttachListener::init();
            }
          }

        #share/vm/runtime/os.cpp

        static void signal_thread_entry(JavaThread* thread, TRAPS) {
          os::set_priority(thread, NearMaxPriority);
          while (true) {
            ...
            switch (sig) {
              case SIGBREAK: {
                // Check if the signal is a trigger to start the Attach Listener - in that
                // case don't print stack traces.
                if (!DisableAttachMechanism && AttachListener::is_init_trigger()) {
                  continue;
                }
        
**Read and excute an operation sent by external utility**

There is loop in attach listener thread of JVM, that reads an operation from socket executes it and
write the result to the socket. 

        #share/vm/services/attachListener.cpp
        
        static void attach_listener_thread_entry(JavaThread* thread, TRAPS) {
          os::set_priority(thread, NearMaxPriority);
        
          if (AttachListener::pd_init() != 0) {
            return;
          }
          AttachListener::set_initialized();
        
          for (;;) {
            AttachOperation* op = AttachListener::dequeue();
        
            // handle special detachall operation
            if (strcmp(op->name(), AttachOperation::detachall_operation_name()) == 0) {
              AttachListener::detachall();
            } else {
              // find the function to dispatch too
              AttachOperationFunctionInfo* info = NULL;
              for (int i=0; funcs[i].name != NULL; i++) {
                const char* name = funcs[i].name;
                assert(strlen(name) <= AttachOperation::name_length_max, "operation <= name_length_max");
                if (strcmp(op->name(), name) == 0) {
                  info = &(funcs[i]);
                  break;
                }
              }
        
              // check for platform dependent attach operation
              if (info == NULL) {
                info = AttachListener::pd_find_operation(op->name());
              }
        
              if (info != NULL) {
                // dispatch to the function that implements this operation
                res = (info->func)(op, &st);
              } else {
                st.print("Operation %s not recognized!", op->name());
                res = JNI_ERR;
              }
            }
        
            // operation complete - send result and output to client
            op->complete(res, &st);
         }
       }
        

