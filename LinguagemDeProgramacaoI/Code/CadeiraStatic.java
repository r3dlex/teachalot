public class CadeiraStatic {
  static int numeroDePernas;
  static int numeroDeBracos;

  public static void main(String[] args) {
    CadeiraStatic umaCadeira = new CadeiraStatic();
    CadeiraStatic outraCadeira = new CadeiraStatic();

    umaCadeira.numeroDePernas = 3;
    outraCadeira.numeroDePernas = 5;
    outraCadeira.numeroDeBracos = 2;
    umaCadeira.numeroDeBracos = 0;
    System.out.println("umacadeira tem " + 
        umaCadeira.numeroDePernas + " pernas e " +
         umaCadeira.numeroDeBracos + " bracos");
    System.out.println("outraCadeira tem " + 
        outraCadeira.numeroDePernas +  " pernas e " + 
       outraCadeira.numeroDeBracos + " bracos");
  }
}
