public class Foo{
  public static void main(String[] arg){
     System.out.println("Hello");
     try {
       Thread.sleep(1000*60);   
     }catch(InterruptedException ex){
     }
     System.out.println("Bye");
  }
}
