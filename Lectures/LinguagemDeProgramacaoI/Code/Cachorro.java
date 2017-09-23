public class Cachorro extends Animal {
  protected boolean _temPelo;

  @Override
  public void fazerAcao() {
    System.out.println("Woof!");
  }

  public static void main(String[] args) {
    Cachorro cachorro = new Cachorro();
    cachorro.fazerAcao();
  }
}
