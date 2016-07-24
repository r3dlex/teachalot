// Define o listener genérico para os botões do RadioGroup
final OnClickListener radioListener = new OnClickListener() {
  @Override
  public void onClick(View v) {
    RadioButton rb = (RadioButton) v;
    tv.setText(rb.getText() + " selecionada");
  }
};

final RadioButton escolha1 = (RadioButton) 
  findViewById(R.id.escolha1);
escolha1.setOnClickListener(radioListener);

final RadioButton escolha2 = (RadioButton) 
  findViewById(R.id.escolha2);
escolha2.setOnClickListener(radioListener);

final RadioButton escolha3 = (RadioButton) 
  findViewById(R.id.escolha3);
escolha3.setOnClickListener(radioListener);
