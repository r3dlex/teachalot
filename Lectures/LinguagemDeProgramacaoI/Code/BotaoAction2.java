import javax.swing.JButton;
import javax.swing.JFrame;

public class BotaoAction2 {
	public static void main(String[] args) {
		JFrame frame = new JFrame("Teste de acoes");
		frame.setSize(400, 300);
		JButton botao = new MeuBotao();
		botao.setSize(50, 50);
		frame.add(botao);
		frame.pack();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);

	}
}
