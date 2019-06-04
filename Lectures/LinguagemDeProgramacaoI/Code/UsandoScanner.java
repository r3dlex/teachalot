import java.util.Scanner;

public class UsandoScanner {
  public static void main(String[] args) {
    //Le a partir da linha de comando
    Scanner sc = new Scanner(System.in); 
    System.out.print("Digite um texto: ");
    String umaString = sc.next();
    System.out.println("Lido " + umaString);
  }
}
