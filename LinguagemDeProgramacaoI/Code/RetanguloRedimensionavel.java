public class RetanguloRedimensionavel 
  implements Forma, Redimensionavel {

	double _largura, _altura;

	public RetanguloRedimensionavel(double largura, double altura) {
		_largura = largura;
		_altura = altura;
	}

	public void escalar(double escala) { //Redimensionavel
		_largura *= escala;
		_altura *= escala;
	}

	public double getArea() { //Forma
		return _largura * _altura;
	}

	public double getPerimetro() { //Forma
		return 2 * _largura + 2 * _altura;
	}
}
