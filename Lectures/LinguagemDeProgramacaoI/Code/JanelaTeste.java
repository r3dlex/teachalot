import javax.swing.JFrame;

public class JanelaTeste extends JFrame {
	public JanelaTeste() {
		super("Ola mundo!"); //Chama construtor
	}

	public static void main(String[] args) {
		JanelaTeste teste = new JanelaTeste();
    //Fecha somente ao clicar no 'X'
		teste.setDefaultCloseOperation(EXIT_ON_CLOSE);
    //Tamanho inicial = 400 linhas x 300 colunas
		teste.setSize(400, 300);
    // Visivel
		teste.setVisible(true);
	}
}
