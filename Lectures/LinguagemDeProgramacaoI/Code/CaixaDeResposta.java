import javax.swing.JOptionPane;

public class CaixaDeResposta {
	public static void main(String[] args) {
		String nome = null;
		nome = JOptionPane.showInputDialog("Qual eh o seu nome?");
		JOptionPane.showConfirmDialog(null, "O seu nome eh " + nome + "?");
	}
}
