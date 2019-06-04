#include <stdio.h>

int fatorial(int n)
{
  if (n == 0)
    return 1;
  else
    return n * fatorial(n - 1);
}

int main()
{
  int n;

  printf("Entre com um valor: ");
  scanf("%d", &n);

  if (n >= 0) 
  {
    for (int i = 0; i <= n; i++)
    {
      printf("fatorial(%d) = %d\n", i, fatorial(i));
    }
  }
  else 
  {
    printf("Argumento invalido!\n");
  }

  return 0;
}
