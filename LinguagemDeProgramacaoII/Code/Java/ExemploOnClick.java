//Chamado ao clicar no mostrarMapa
botao.setOnClickListener(new OnClickListener() {}) {
  public void onClick(View v) {
    try {
      // Processo o texto para ser transmitido pela rede
      String endereco = textoDeEndereco.getText().toString();
      endereco = endereco.replace(' ', '+');
      // ...
    } catch (Exception e) {
      // Log de erros vai para o logcat
      Log.e(TAG, e.toString());
    }
  }
}
