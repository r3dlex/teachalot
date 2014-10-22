import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class LendoTexto {
	public static void main(String[] args) throws IOException {
		BufferedReader leitor = null;
		try {
			leitor = new BufferedReader(new FileReader(
					"C:\\Caminho\\Para\\O\\Arquivo.txt"));
			String linha = null;
			while ((linha = leitor.readLine()) != null) {		
        /* ... */
			}
		} catch (IOException e) {
			e.printStackTrace();
			leitor.close();
		}
	}
}
