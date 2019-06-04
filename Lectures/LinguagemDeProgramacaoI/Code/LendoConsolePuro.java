public class LendoConsolePuro {
  public static void main(String[] args) {
    System.out.print("Entre o valor: ");
    String line = System.console().readLine();
    System.out.println("Valor lido: " + line);
  }
}
