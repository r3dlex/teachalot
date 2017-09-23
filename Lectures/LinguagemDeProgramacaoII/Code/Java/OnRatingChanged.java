bar.setOnRatingBarChangeListener(new OnRatingBarChangeListener() {
  // Chamado toda vez que a barra é acionada
  @Override
  public void onRatingChanged(RatingBar ratingBar, float valor, 
    boolean doUsuario) {

    tv.setText("Valor: " + valor);
  }
});
