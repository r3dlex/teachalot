try {
  //...
}
catch (NomeDaExcecao | NomeDeOutraExcecao excecao) {
  loger.logar(excecao); //Log da excecao
  throw execao; //Relanca a excecao
}
finally {
  //...
}
