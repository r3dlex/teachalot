public class ListaDeAnimais {
	private Animal _animais[];
	private int _tamanho;
	
	ListaDeAnimais() {
		// Testar com pelo menos 4 animais!
		_tamanho = 4;
		_animais = new Animal[_tamanho];
	}
	
	public boolean adicionar(Animal animal) {
		if (!estahCheio()) {
			// guardar animal no array
			_tamanho += 1;
			return true;
		}
		return false;
	}
	
	public boolean remover(String nome) {
		int indice = temAnimal(nome);
		if (indice != -1) {
			//for (int i = ?; i < _tamanho; ++i)
			//	Copiar sobre a posicao no array os animais subsequentes
			_tamanho -= 1;
			return true;
		}
		return false;
	}
	
	public int temAnimal(String nome) {
		//Checar se ha algum animal
		//for (int i = 0; i < _tamanho; ++i) ...
		//Verificar se tem animal cujo nome seja igual ao referido
		return -1;
	}

	public boolean estahCheio() {
		// Implementar checando o tamanho
		return false;
	}
	
	public boolean estahVazio() {
		// Implementar checando o tamanho
		return false;
	}
	
	public int getTamanho() {
		return _tamanho;
	}
	
	public static void main(String[] args) {
		// Inicializar a lista de animais e fazer varias operacoes
		// Testando todos os metodos implementados
	}
}
