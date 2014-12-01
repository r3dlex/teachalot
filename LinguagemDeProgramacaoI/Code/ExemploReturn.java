public class ExemploReturn {
  public static int multiploDeTres(int n) {
    while (true) {
      if (n % 3 == 0) {
        return n;
      }
      n++;
    }
  }
  public static void main(String[] args) {
    for (int i = 2100; i < 2105; ++i) {
      System.out.println("i = " + i + 
          " m3 = " + multiploDeTres(i));
    }
  }
}
