public class ImprimirLinhas {
  public static void imprimirLinha() {
    System.out.println("");
  }

  public static void imprimirDuasLinhas() {
    imprimirLinha();
    imprimirLinha();
  }

  public static void main(String[] args) {
    System.out.println("Comecando impressao de linhas");
    imprimirDuasLinhas();
    System.out.println("Terminando impressao de linhas");
  }
}
