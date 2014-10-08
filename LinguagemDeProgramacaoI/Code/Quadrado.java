public class Quadrado extends Retangulo {
	Quadrado(int lado) {
		super(lado, lado);
	}
	
	public int area() {
		return _largura * _largura;
	}
	
	public int perimetro() {
		return 4 * _largura;
	}
}
