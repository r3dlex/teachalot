public class OperadoresUnarios {
  public static void main(String[] args) {
    int v1 = 20;
    int v2 = 15;

    int resultado1 = v1++ + --v2;
    System.out.println("Resultado: " + (resultado1));
    System.out.println("Resultado: " + (v1 + v2));
    int resultado2 = v1-- + v2;
    System.out.println("Resultado: " + resultado2);
  }
}
