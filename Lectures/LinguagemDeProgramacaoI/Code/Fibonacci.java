public static int calcular(int x) {
  if (x == 1) {
    return 1;
  }
  else if (x == 0) {
    return 0;
  }
  else {
    int n[] = new int[2];
    n[0] = 0;
    n[1] = 1;
    int resultado = 0;
    for (int i = 2; i <= x; ++i) {
      resultado = n[1] + n[0];
      n[0] = n[1];
      n[1] = resultado;
    }
    return resultado;
  }
}
