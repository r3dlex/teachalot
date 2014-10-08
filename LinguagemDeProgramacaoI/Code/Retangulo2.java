public class Retangulo extends Forma {
  private float _largura;
  private float _altura;

  Retangulo(float largura, float altura) {
    _largura = largura;
    _altura = altura;
  }

  @Override
  public float calcularArea() {
    return _largura * _altura;
  }

  @Override
  public float calcularPerimetro() {
    return 2 * _largura + 2 * _altura;
  }
}
