public class ExemploContinue {
  public static void main(String[] args) {
    int i = 2;
    int j = 3;
    boolean deveContinuar = true;
    while (deveContinuar) {
      if (j % i != 100) {
        i += 2;
        j += 3;  
        continue; 
      }
      deveContinuar = false; 
    }
    System.out.println("j = " + j + " i = " + i);
  }
}
