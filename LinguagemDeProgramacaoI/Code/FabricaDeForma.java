public class FabricaDeForma {
   public Forma getForma(String nomeDaForma){
      if(nomeDaForma != null){
        if(nomeDaForma.equalsIgnoreCase("Circulo")){
          return new Circulo();
        } else if(nomeDaForma.equalsIgnoreCase("Retangulo")){
          return new Retangulo();
        } else if(nomeDaForma.equalsIgnoreCase("Quadrado")){
          return new Quadrado();
        }
      }
      return null;
   }
}
