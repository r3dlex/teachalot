public class ArrayExcecao {
  /*...*/

  public static void main(String[] args) {
    try {
      naPosicao(-1);
    }
    catch (ArrayIndexOutOfBoundsException ex) {
      ex.printStackTrace(); //mostra dump no console
    }
  }
}
