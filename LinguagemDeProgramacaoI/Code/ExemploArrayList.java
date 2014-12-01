import java.util.ArrayList;

public class ExemploArrayList {
  public static void main(String[] args) {
    ArrayList<String> lista = new ArrayList<String>();
    for (int i = 0; i <= 4; ++i) {
      System.out.println("Tamanho da lista=" + lista.size());
      lista.add("E");
    }
  }
}
