import java.util.LinkedList;

public class ExemploLinkedList {
  public static void main(String[] args) {
    LinkedList<String> lista = new LinkedList<String>();
    for (int i = 0; i <= 4; ++i) {
      System.out.println("Tamanho da lista=" + lista.size());
      lista.add("E");
    }
  }
}
