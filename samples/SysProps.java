import java.util.*;

public class SysProps{
  public static void main(String[] arg){
     Properties p=System.getProperties(); 
     Enumeration keys = p.keys();
     while (keys.hasMoreElements()) {
      String key = (String)keys.nextElement();
      String value = (String)p.get(key);
      System.out.println(key + ": " + value);
     }
  }
}
