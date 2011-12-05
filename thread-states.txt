2. java.lang.Thread.State

A thread state. A thread can be in one of the following states:

  NEW : A thread that has not yet started is in this state.
  RUNNABLE : A thread executing in the Java virtual machine is in this state.
  BLOCKED : A thread that is blocked waiting for a monitor lock is in this state.
  WAITING : A thread that is waiting indefinitely for another thread to perform a particular action is in this state.
  TIMED_WAITING : A thread that is waiting for another thread to perform an action for up to a specified waiting time is in this state.
  TERMINATED : A thread that has exited is in this state.

  "ajp-0.0.0.0-8039-177" daemon prio=10 tid=0x6347e800 nid=0x3fa6 runnable [0x5d9ff000]
   java.lang.Thread.State: RUNNABLE
        at java.io.UnixFileSystem.getLastModifiedTime(Native Method)

   "ajp-0.0.0.0-8039-175" daemon prio=10 tid=0x625c8800 nid=0x3f45 waiting for monitor entry [0x5da40000]
   java.lang.Thread.State: BLOCKED (on object monitor)
        at java.util.Collections$SynchronizedMap.get(Collections.java:1990)
        - waiting to lock <0x77182240> (a java.util.Collections$SynchronizedMap)
        at org.apache.axis.description.TypeDesc.getTypeDescForClass(TypeDesc.java:116)

  "ajp-0.0.0.0-8039-39" daemon prio=10 tid=0x5f11fc00 nid=0x1dd9 in Object.wait() [0x62464000]
   java.lang.Thread.State: WAITING (on object monitor)
        at java.lang.Object.wait(Native Method)
        at java.lang.Object.wait(Object.java:502)
        at org.apache.tomcat.util.net.JIoEndpoint$Worker.await(JIoEndpoint.java:416)
        - locked <0xa2f57238> (a org.apache.tomcat.util.net.JIoEndpoint$Worker)
        at org.apache.tomcat.util.net.JIoEndpoint$Worker.run(JIoEndpoint.java:442)
        at java.lang.Thread.run(Thread.java:636)

  "Thread-5" prio=10 tid=0x635bb000 nid=0x2e8c waiting on condition [0x62afe000]
   java.lang.Thread.State: TIMED_WAITING (sleeping)
        at java.lang.Thread.sleep(Native Method)
        at com.arjuna.ats.internal.arjuna.recovery.PeriodicRecovery.doWork(PeriodicRecovery.java:248)
        at com.arjuna.ats.internal.arjuna.recovery.PeriodicRecovery.run(PeriodicRecovery.java:163)


