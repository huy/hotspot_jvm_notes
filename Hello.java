import java.util.Random;

public class Hello{
  public static void main(String[] arg){
     System.out.println("Say Hello");

     Random r = new Random();
     int sum =1;
     for(int i=0; i < 1000; i++){
       int[] a = new int[5*1024*1024]; // hope to kickoff GC
       sum += a[r.nextInt(5*1024*1024-1)];
     }

     try {
       Thread.sleep(1000*60);   
     }catch(InterruptedException ex){
     }

     System.out.println("Say Bye " + sum);
  }
}
