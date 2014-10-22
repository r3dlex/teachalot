import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class LendoTexto {
	public static void main(String[] args) throws IOException {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(
					"C:\\Caminho\\Para\\O\\Arquivo.txt"));
			String linha = null;
			while ((linha = reader.readLine()) != null) {		
        /* ... */
			}
		} catch (IOException e) {
			e.printStackTrace();
			reader.close();
		}
	}
}
