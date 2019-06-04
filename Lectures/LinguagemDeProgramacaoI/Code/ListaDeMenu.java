public class ListaDeMenu {
	public static void main(String args []) {
		ItemDeMenu [] menuItens = new ItemDeMenu[4];
		menuItens[0] = new ItemDeMenu("Menu 1");
		menuItens[1] = new ItemDeMenu("Menu 2");
		menuItens[2] = new ItemDeMenu("Menu 3");
		menuItens[3] = new ItemDeMenu("Menu 4");
		
		for (int i=0; i < menuItens.length; i++) {
			System.out.println(menuItens[i].nome);
		}
	}
}
