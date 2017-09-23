public class ArrayExcecao {
	Object[] objetos_;

	public Object naPosicao(int indice) 
			throws ArrayIndexOutOfBoundsException {
		
		if (indice < 0 || indice > objetos_.length) {
			throw new ArrayIndexOutOfBoundsException(indice);
		}
		return objetos_[indice];
	}
}
