public class TestLock {
    public static void main(String[] args) throws Exception {
        final Object lock = new Object();
        Thread thread = new Thread() {
            @Override
            public void run() {
                System.out.println("Locking on: " + Integer.toHexString(System.identityHashCode(lock)));
                synchronized (lock) {
                    System.out.println("Hello, world!");
                }   
            }   
        };  
        synchronized (lock) {
            thread.start();
            Thread.sleep(600 * 1000);
            System.out.println("bye!");
        }   
    }   
} 
