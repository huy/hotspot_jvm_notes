public class MeaningOfLife {
  public static String findOutWhatLifeIsAllAbout(int factor) {
    int meaning = 0;
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 20; j++) {
        for (int k = 0; k < 300; k++) {
          for (int m = 0; m < 7000; m++) {
            meaning += Math.random() + factor;
          }
        }
      }
    }
    return String.valueOf(meaning).replaceAll("0*$", "");
  }

  public static void main(String[] args) {
    int factor=0;
    if(args.length > 0)
       factor = Integer.valueOf(args[0]);
    System.out.println(findOutWhatLifeIsAllAbout(factor));
  }
}
