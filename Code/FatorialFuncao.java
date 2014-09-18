public class FatorialFuncao {
  public static int fatorial(int n) {
    int fat = 1;
    for (int i = 1; i <= n; ++i) {
      fat *= i;
    }
    return fat;
  }
  
  public static void main(String[] args) {
    for (int i = 0; i < 10; ++i) {
      System.out.println("i = " + i + 
          ", fat = " + fatorial(i));
    }
  }
}
