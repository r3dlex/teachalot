import java.io.DataOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class EscreverBinario {
	public static void main(String[] args) throws IOException {
		DataOutputStream escritor = new DataOutputStream(
        new FileOutputStream("C:\\file.dat"));
		escritor.writeInt(8);
    escritor.writeChar('H');
    escritor.writeDouble(2.0);
    //...
	}
}

