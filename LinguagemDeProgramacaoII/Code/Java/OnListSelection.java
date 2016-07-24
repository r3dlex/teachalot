public void onListSelection(int indice) {
  // Se o FragmentCitacao não foi adicionado, o adicionamos
  if (!_fragmentoCitacao.isAdded()) {
    // Nova FragmentTransaction
    FragmentTransaction fragmentoTransacao = _gerenteDeFragmentos
      .beginTransaction();

    // Adiciona o FragmentoTitulos no container
    fragmentoTransacao.add(R.id.container_citacao,
        _fragmentoCitacao);

    // Adiciona no task backstack
    fragmentoTransacao.addToBackStack(null);

    // Atualiza o FragmentTransaction
    fragmentoTransacao.commit();

    // Força a atualização do FragmentTransaction
    _gerenteDeFragmentos.executePendingTransactions();
  }
  ...
}
