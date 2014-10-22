import java.io.DataOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class EscreverBinario {
	public static void main(String[] args) throws IOException {
		DataOutputStream escritor = new DataOutputStream(new FileOutputStream("/tmp/file.dat"));
		escritor.writeInt(8);
		escritor.writeChar('P');
		escritor.writeChar('A');
		escritor.writeChar('R');
		escritor.writeChar('A');
		escritor.writeChar('B');
		escritor.writeChar('E');
		escritor.writeChar('N');
		escritor.writeChar('S');
	}
}
