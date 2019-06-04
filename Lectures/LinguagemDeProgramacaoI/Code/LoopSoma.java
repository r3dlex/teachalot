public class LoopSoma {
  public static void main(String[] args) {
    int soma = 0;
    for (int i = 0; i < 5; ++i) {
      soma = soma + i; //soma += i;
    }
    System.out.println(soma);
  }
}
