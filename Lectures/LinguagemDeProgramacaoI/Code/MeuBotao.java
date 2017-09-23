import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;

public class MeuBotao extends JButton implements ActionListener {
  MeuBotao() {
    super("Pressione");
    this.addActionListener(this);
  }

  @Override
  public void actionPerformed(ActionEvent e) {
    System.out.println("Pressionou!");
  }

}
