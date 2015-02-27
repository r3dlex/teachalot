int somatorio(int* valores, int n) {
  int soma = 0;
  for (int i = 0; i < n; ++i) {
    soma += valores[i];
  }
  return soma;
}
