public class MenuIterator implements Iterator {
	ItemDeMenu[] _itens;
	int posicao = 0;
	
	public MenuIterator(ItemDeMenu[] _itens) {
		_itens = _itens;
	}
	
	public Object next() {
		ItemDeMenu menuItem = _itens[posicao];
		posicao++;
		return menuItem;
	}
	
	public boolean hasNext() {
		if (posicao >= _itens.length || _itens[posicao] == null) {
			return false;
		} else {
			return true;
		}
	}
	
} 
