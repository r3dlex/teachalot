boolean ehQuadradoPerfeito(int numero) {
  if (numero < 0)
    return false;

  boolean achou = false;
  for (int i = 0; i < numero; ++i) {
    if (i * i == numero) {
      achou = true;
      break;
    }
  }
  return achou;
}
