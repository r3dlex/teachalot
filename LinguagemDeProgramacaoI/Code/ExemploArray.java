public class ExemploArray {
  public static void main(String[] args) {
    int[] valores = new int[4];
    System.out.println("tamanho = " + valores.length);
    valores[0] = 1;
    valores[1] = valores[0] + valores[2];
    valores[2] = 30;
    valores[3] = 25;
  }
}
