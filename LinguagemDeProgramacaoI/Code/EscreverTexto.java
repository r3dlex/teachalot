import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

public class EscreverTexto {
	public static void main(String[] args) {
		try {
			BufferedWriter escritor = new BufferedWriter(
					new OutputStreamWriter(new FileOutputStream(
							"C:\\saida.txt"), "utf-8"));
			escritor.write("Lorem ipsum");
			escritor.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
