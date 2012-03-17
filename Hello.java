public class Hello{
  public static void main(String[] arg){
     System.out.println("Say Hello");
     int sum =1;
     for(int i=0; i < 1000*100; i++)
        sum = sum + i;

     try {
       Thread.sleep(1000*60);   
     }catch(InterruptedException ex){
     }

     System.out.println("Say Bye " + sum);
  }
}
