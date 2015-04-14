# JVM internal threads

In addition to User threads created by a java program, when the JVM starts, it creates several internal threads 
each is responsible for handling certain activities of JVM. 

Looking a most simple output of jstack

        "Attach Listener" daemon prio=10 tid=0x094a6c00 nid=0x3509 runnable [0x00000000]
           java.lang.Thread.State: RUNNABLE
        
        "Low Memory Detector" daemon prio=10 tid=0x09496c00 nid=0x34fe runnable [0x00000000]
           java.lang.Thread.State: RUNNABLE
        
        "C2 CompilerThread1" daemon prio=10 tid=0x09494800 nid=0x34fd waiting on condition [0x00000000]
           java.lang.Thread.State: RUNNABLE
        
        "C2 CompilerThread0" daemon prio=10 tid=0x09492800 nid=0x34fc waiting on condition [0x00000000]
           java.lang.Thread.State: RUNNABLE
        
        "Signal Dispatcher" daemon prio=10 tid=0x09491000 nid=0x34fb runnable [0x00000000]
           java.lang.Thread.State: RUNNABLE
        
        "Finalizer" daemon prio=10 tid=0x0947e400 nid=0x34fa in Object.wait() [0x9ce63000]
           java.lang.Thread.State: WAITING (on object monitor)
        	at java.lang.Object.wait(Native Method)
        	- waiting on <0x9d261160> (a java.lang.ref.ReferenceQueue$Lock)
        	at java.lang.ref.ReferenceQueue.remove(ReferenceQueue.java:133)
        	- locked <0x9d261160> (a java.lang.ref.ReferenceQueue$Lock)
        	at java.lang.ref.ReferenceQueue.remove(ReferenceQueue.java:149)
        	at java.lang.ref.Finalizer$FinalizerThread.run(Finalizer.java:177)
        
        "Reference Handler" daemon prio=10 tid=0x0947cc00 nid=0x34f9 in Object.wait() [0x9ceb4000]
           java.lang.Thread.State: WAITING (on object monitor)
        	at java.lang.Object.wait(Native Method)
        	- waiting on <0x9d261060> (a java.lang.ref.Reference$Lock)
        	at java.lang.Object.wait(Object.java:502)
        	at java.lang.ref.Reference$ReferenceHandler.run(Reference.java:133)
        	- locked <0x9d261060> (a java.lang.ref.Reference$Lock)
        
        "main" prio=10 tid=0x09427000 nid=0x34f7 waiting on condition [0xb7f75000]
           java.lang.Thread.State: TIMED_WAITING (sleeping)
        	at java.lang.Thread.sleep(Native Method)
        	at Foo.main(Foo.java:5)
        
        "VM Thread" prio=10 tid=0x09478c00 nid=0x34f8 runnable 
        
        "VM Periodic Task Thread" prio=10 tid=0x0949a000 nid=0x34ff waiting on condition 

The "main" is only user thread that executes main method of java class Foo. All others threads are Hotspot internal
threads.

* "Attach Listener" is internal thread that listens on UNIX socket, receives and executes command sent by 
utilities like jstack, jmap, jhat. This thread is kicked off the first time when signal QUIT is received
* "VM Thread" is reponsible to execute VM operations e.g. PrintThreads, ThreadStop, GenCollectFull. These VM operations may required
execution at safepoint
* "C2 CompilerThread0" and "C2 CompilerThread1" are responsible for compile bytecode to machine code.
* "Signal Dispatcher" is responsible for handling signals sent to the JVM
* "Finalizer" is responsible for executing object's finalizer method
* "Reference Handler" is responsible for clearing soft, weak, phantom references according policy and state of memory
* "Low Memory Detector" detect if the JVM has low memory
* "VM Periodic Task Thread" executes periodic activities that are submitted by java.util.Timer,java.util.TimerTask 

**References**

* http://openjdk.java.net/groups/hotspot/docs/RuntimeOverview.html

