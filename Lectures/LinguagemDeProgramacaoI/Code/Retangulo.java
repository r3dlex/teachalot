public class Retangulo {
  int _largura;
  int _altura;

  Retangulo(int largura, int altura) {
    _largura = largura;
    _altura = altura;
  }

  public int area() {
    return _largura * _altura;
  }

  public int perimetro() {
    return 2 * _largura + 2 * _altura;
  }
}
