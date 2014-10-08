public class Variavel<Tipo> {
	Tipo Get() {
		return _variavel;
	}

	void Set(Tipo novoValor) {
		_variavel = novoValor;
	}

	Tipo _variavel;
	
	public static void main(String[] args) {
		Variavel<Integer> varInt; //0
		Variavel<Double> varDouble; //0.0
		varInt.Set(30); //30
		varDouble.Set(30); //Erro!
		varDouble.Set(30.0); //30.0
	}
}
