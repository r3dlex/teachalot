import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;

public class LerBinario {
	public static void main(String[] args) throws IOException {
		DataInputStream leitor = new DataInputStream(
        new FileInputStream("C:\\file.dat"));
		int numero = leitor.readInt();
    char caracter = leitor.readChar();
    byte umByte = leitor.readByte();
    int outroByte = leitor.read();
    double umDouble = leitor.readDouble();
    //...
	}
}
