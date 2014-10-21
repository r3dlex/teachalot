import java.io.FileReader;
import java.io.FileNotFoundException;

public class AbrirArquivo {
  public static void main(String[] args) {
    try {
      FileReader fr = new FileReader("C:/teste.txt");
    }
    catch (FileNotFoundException ex) {
      ex.printStackTrace();
    }
  }
}
