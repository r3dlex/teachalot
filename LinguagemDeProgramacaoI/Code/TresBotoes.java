import java.awt.Component;
import java.awt.Container;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.MouseListener;

import javax.swing.JButton;
import javax.swing.JFrame;

public class TresBotoes {
	private static final Insets espaco = new Insets(5, 5, 5, 5);

	public static void main(final String args[]) {
		final JFrame janela = new JFrame("GridBagLayout");
		janela.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		janela.setLayout(new GridBagLayout());
		JButton botao;
		// Linha um - três botões
		botao = new JButton("Um");
		adicionarComponente(janela, botao, 0, 0, 1, 1, GridBagConstraints.CENTER,
				GridBagConstraints.BOTH);
		botao = new JButton("Dois");
		adicionarComponente(janela, botao, 1, 0, 1, 1, GridBagConstraints.CENTER,
				GridBagConstraints.BOTH);
		botao = new JButton("Tres");
		adicionarComponente(janela, botao, 2, 0, 1, 1, GridBagConstraints.CENTER,
				GridBagConstraints.NONE);
		
		janela.setSize(500, 200);
		janela.setVisible(true);
	}

	private static void adicionarComponente(Container container, Component componente,
			int gridx, int gridy, int larguraGrid, int alturaGrid, int ancora,
			int expansao) {
		GridBagConstraints gbc = new GridBagConstraints(gridx, gridy,
				larguraGrid, alturaGrid, 1.0, 1.0, ancora, expansao, espaco, 0, 0);
		container.add(componente, gbc);
		
	}
}	
