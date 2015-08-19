int somatorio(int* array, int n) 
{
  int soma = 0;
  for (int i = 0; i < n; ++i) 
  {
    soma += array[i];
  }
  return soma;
}
