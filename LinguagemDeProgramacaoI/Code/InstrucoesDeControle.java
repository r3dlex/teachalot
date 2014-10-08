boolean ehQuadradoPerfeito(int numero) {
  if (numero < 0)
    return false;

  int i = 0;
  while (i < numero) {
    if (i * i != numero) {
      i++;
      continue;
    }
    break;
  }
  return i < numero;
}
