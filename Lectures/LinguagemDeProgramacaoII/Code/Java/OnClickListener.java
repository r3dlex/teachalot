// Pega a referência ao botão CheckBox.
final Button button = (Button) findViewById(R.id.botao);
button.setOnClickListener(new OnClickListener() {
  @Override
  public void onClick(View v) {

    // Muda o estado de visibilidade da CheckBox e seta o
    // Texto do botão para estar de acordo com ele
    if (checkbox.isShown()) {
      checkbox.setVisibility(View.INVISIBLE);
      button.setText("Mostrar CheckBox");
    } else {
      checkbox.setVisibility(View.VISIBLE);
      button.setText("Esconder CheckBox");
    }
  }
});
