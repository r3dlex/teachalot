import javax.swing.JOptionPane;

public class DialogoCompleto {
	public static void main(String[] args) {
		String nome = null;
		int resposta;
		nome = JOptionPane.showInputDialog("Qual eh o seu nome?");
		resposta = JOptionPane.showConfirmDialog(null, 
        "O seu nome eh " + nome + "?");
		if (resposta == JOptionPane.YES_OPTION) {
			JOptionPane.showMessageDialog(null, "Seu nome eh " + nome);
		} else {
			JOptionPane.showMessageDialog(null, "Seu nome nao eh " + nome);
		}
	}
}

