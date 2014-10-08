public class ExemploOverride {
  public class Animal {
    public void acao() {
      System.out.println("O animal se move!");
    }
  }

  public class Cachorro extends Animal {
    @Override
    public void acao() {
      System.out.println("Latir!");
    }
  }
}
