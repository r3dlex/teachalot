import java.awt.event.*;
import javax.swing.*;

public class BotaoAction {
	public static void main(String[] args) {
		JFrame frame = new JFrame("Teste de acoes");
		frame.setSize(400, 300);
		JButton botao = new JButton();
		botao.setSize(50, 50);
		frame.add(botao);
		botao.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				System.out.println("Pressionou!");
			}
		});
		frame.pack();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);

	}
}

