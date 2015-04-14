# How jstack works

**jstack program main class**

The jstack program attaches to running JVM using pid, connecto UNIX socket created by Attach Listener Thread of
the running JVM to send command threaddump

        #sun/tools/jstack/JStack.java:

        public class JStack {
            public static void main(String[] args) throws Exception {
                if (args.length == 0) {
                    usage(); // no arguments
                }
        
        ...
                // mixed stack implies SA tool
                if (mixed) {
                    useSA = true;
                }
        
        ...
        
                if (useSA) {
                    // parameters (<pid> or <exe> <core>
                    String params[] = new String[paramCount];
                    for (int i=optionCount; i<args.length; i++ ){
                        params[i-optionCount] = args[i];
                    }
                    runJStackTool(mixed, locks, params);
                } else {
                    // pass -l to thread dump operation to get extra lock info
                    String pid = args[optionCount];
                    String params[];
                    if (locks) {
                        params = new String[] { "-l" };
                    } else {
                        params = new String[0];
                    }
                    runThreadDump(pid, params);
                }
        

        #sun/tools/jstack/JStack.java:
          private static void runThreadDump(String pid, String args[]) throws Exception {
            VirtualMachine vm = null;
            try {
                vm = VirtualMachine.attach(pid);
            } catch (Exception x) {
                String msg = x.getMessage();
                if (msg != null) {
                    System.err.println(pid + ": " + msg);
                } else {
                    x.printStackTrace();
                }
                if ((x instanceof AttachNotSupportedException) &&
                    (loadSAClass() != null)) {
                    System.err.println("The -F option can be used when the target " +
                        "process is not responding");
                }
                System.exit(1);
            }

            // Cast to HotSpotVirtualMachine as this is implementation specific
            // method.
            InputStream in = ((HotSpotVirtualMachine)vm).remoteDataDump((Object[])args);

            // read to EOF and just print output
            byte b[] = new byte[256];
            int n;
            do {
                n = in.read(b);
                if (n > 0) {
                    String s = new String(b, 0, n, "UTF-8");
                    System.out.print(s);
                }
            } while (n > 0);
            in.close();
            vm.detach();

        #sun/tools/jstack/JStack.java:

            private static void runJStackTool(boolean mixed, boolean locks, String args[]) throws Exception {
                Class<?> cl = loadSAClass();
                if (cl == null) {
                    usage();            // SA not available
                }
        
                // JStack tool also takes -m and -l arguments
                if (mixed) {
                    args = prepend("-m", args);
                }
                if (locks) {
                    args = prepend("-l", args);
                }
        
                Class[] argTypes = { String[].class };
                Method m = cl.getDeclaredMethod("main", argTypes);
        
                Object[] invokeArgs = { args };
                m.invoke(null, invokeArgs);
            }
        

        #sun/tools/jstack/JStack.java:
            private static Class loadSAClass() {
                //
                // Attempt to load JStack class - we specify the system class
                // loader so as to cater for development environments where
                // this class is on the boot class path but sa-jdi.jar is on
                // the system class path. Once the JDK is deployed then both
                // tools.jar and sa-jdi.jar are on the system class path.
                //
                try {
                    return Class.forName("sun.jvm.hotspot.tools.JStack", true,
                                         ClassLoader.getSystemClassLoader());
                } catch (Exception x)  { }
                return null;
            }
        

        #sun/tools/attach/HotSpotVirtualMachine.java:

            // Remote ctrl-break. The output of the ctrl-break actions can
            // be read from the input stream.
            public InputStream remoteDataDump(Object ... args) throws IOException {
                return executeCommand("threaddump", args);
            }

          #sun/tools/attach/HotSpotVirtualMachine.java:
            private InputStream executeCommand(String cmd, Object ... args) throws IOException {
                try {
                    return execute(cmd, args);
                } catch (AgentLoadException x) {
                    throw new InternalError("Should not get here");
                }
            }
        

**The execution of threaddump command inside JVM**

The Attatch Listener Thread that read an incomming operation an dispatch it to appropriate function

        #share/vm/services/attachListener.cpp
        static void attach_listener_thread_entry(JavaThread* thread, TRAPS) {
        ...
          for (;;) {
            AttachOperation* op = AttachListener::dequeue();
        
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
         ... 
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
        
Table of functions that implements each operation

        #share/vm/services/attachListener.cpp
        
        // names must be of length <= AttachOperation::name_length_max
        static AttachOperationFunctionInfo funcs[] = {
          { "agentProperties",  get_agent_properties },
          { "datadump",         data_dump },
        #ifndef SERVICES_KERNEL
          { "dumpheap",         dump_heap },
        #endif  // SERVICES_KERNEL
          { "load",             JvmtiExport::load_agent_library },
          { "properties",       get_system_properties },
          { "threaddump",       thread_dump },
          { "inspectheap",      heap_inspection },
          { "setflag",          set_flag },
          { "printflag",        print_flag },
          { NULL,               NULL }
        };

Thread Dump funcion

the thread_dump function create intented VM operations and execute it in the context of VM thread 

        #share/vm/services/attachListener.cpp
        static jint thread_dump(AttachOperation* op, outputStream* out) {
          bool print_concurrent_locks = false;
          if (op->arg(0) != NULL && strcmp(op->arg(0), "-l") == 0) {
            print_concurrent_locks = true;
          }
        
          // thread stacks
          VM_PrintThreads op1(out, print_concurrent_locks);
          VMThread::execute(&op1);
        
          // JNI global handles
          VM_PrintJNI op2(out);
          VMThread::execute(&op2);
        
          // Deadlock detection
          VM_FindDeadlocks op3(out);
          VMThread::execute(&op3);
        
          return JNI_OK;
        }

There are bundle of VM_operation to process different administrative aspects of JVM such as thread, gc, lock, 
they are defined in 

        #share/vm/runtime/vm_operations.hpp

        #define VM_OPS_DO(template)                       \
          template(Dummy)                                 \
          template(ThreadStop)                            \
          template(ThreadDump)                            \
          template(PrintThreads)                          \
          template(FindDeadlocks)                         \
          template(ForceSafepoint)                        \
          template(ForceAsyncSafepoint)                   \
          template(Deoptimize)                            \
          template(DeoptimizeFrame)                       \
          template(DeoptimizeAll)                         \
          template(ZombieAll)                             \
          template(HandleFullCodeCache)                   \
          template(Verify)                                \

        class VM_PrintThreads: public VM_Operation {
         private:
          outputStream* _out;
          bool _print_concurrent_locks;
         public:
          VM_PrintThreads() { _out = tty; _print_concurrent_locks = PrintConcurrentLocks; }
          VM_PrintThreads(outputStream* out, bool print_concurrent_locks)  { _out = out; _print_concurrent_locks = print_concurrent_locks; }
          VMOp_Type type() const  {  return VMOp_PrintThreads; }
          void doit();
          bool doit_prologue();
          void doit_epilogue();
        };
        
        
The operation is add to queue of the VM Thread, a thread of JVM dedicated for executio of administrative operation

        #share/vm/runtime/vmThread.cpp

        void VMThread::execute(VM_Operation* op) {
          Thread* t = Thread::current();
        
          if (!t->is_VM_thread()) {
        ...
            // New request from Java thread, evaluate prologue
            if (!op->doit_prologue()) {
              return;   // op was cancelled
            }
        ...
              VMOperationQueue_lock->lock_without_safepoint_check();
              bool ok = _vm_queue->add(op);
        ... 
            if (execute_epilog) {
              op->doit_epilogue();
            }
          } else {
        ...
        }
        
