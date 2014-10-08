import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class LendoConsole {
	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(
        new InputStreamReader(System.in));
		System.out.print("Entre um valor:");
		String s = br.readLine();
		System.out.print("Lido: " + s);
	}
}
