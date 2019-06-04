public class ExemploBreak {
  public static void main(String[] args) {
    int i = 2;
    int j = 3;
    while (true) {
      if (j % i == 100) {
        System.out.println("j = " + j + " i = " + i);
        break;
      }
      i += 2;
      j += 3;  
    }
  }
}
