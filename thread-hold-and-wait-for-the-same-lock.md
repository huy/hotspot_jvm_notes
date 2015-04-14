
## Thread dump report thread holds and wait for the same lock

It happens in whe `Object.wait` is called inside synchronized block in wait/notify synchronization pattern

**Stack trace**

     "JBoss System Threads(1)-3603" daemon prio=10 tid=0x5dd23800 nid=0x2f93 in Object.wait() [0x5a27b000]
      java.lang.Thread.State: TIMED_WAITING (on object monitor)
        at java.lang.Object.wait(Native Method)
        - waiting on <0x74fd3ca8> (a java.lang.Object)
        at EDU.oswego.cs.dl.util.concurrent.BoundedLinkedQueue.poll(BoundedLinkedQueue.java:253)
        - locked <0x74fd3ca8> (a java.lang.Object)
        at EDU.oswego.cs.dl.util.concurrent.PooledExecutor.getTask(PooledExecutor.java:736)
        at org.jboss.util.threadpool.MinPooledExecutor.getTask(MinPooledExecutor.java:106)
        at EDU.oswego.cs.dl.util.concurrent.PooledExecutor$Worker.run(PooledExecutor.java:760)
        at java.lang.Thread.run(Thread.java:636)

**Source code**

       237  public Object poll(long msecs) throws InterruptedException {
       238    if (Thread.interrupted()) throw new InterruptedException();
       239    Object x = extract();
       240    if (x != null) 
       241      return x;
       242    else {
       243      synchronized(takeGuard_) {
       244        try {
       245          long waitTime = msecs;
       246          long start = (msecs <= 0)? 0: System.currentTimeMillis();
       247          for (;;) {
       248            x = extract();
       249            if (x != null || waitTime <= 0) {
       250              return x;
       251            }
       252            else {
       253              takeGuard_.wait(waitTime); 
       254              waitTime = msecs - (System.currentTimeMillis() - start);
       255            }
       256          }
       257        }
       258        catch(InterruptedException ex) {
       259          takeGuard_.notify();
       260          throw ex; 
       261        }
       262      }
       263    }
       264  }
