public class TesteFabricaDeForma {
   public static void main(String[] args) {
      FabricaDeForma formaFabrica = new FabricaDeForma();

      Forma forma1 = formaFabrica.getForma("Circulo");
      forma1.desenhar();
      Forma forma2 = formaFabrica.getForma("Retangulo");
      forma2.desenhar();
      Forma forma3 = formaFabrica.getForma("Quadrado");
      forma3.desenhar();
   }
}
