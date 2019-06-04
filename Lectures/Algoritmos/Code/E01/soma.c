#include <stdio.h>

int funcaoX(int n) 
{
  int a = 0;

  for (int i = 1; i <= n; ++i)
  {
    a += i;
  }

  return a;
}

int main() 
{
  for (int i = 5; i <= 8; ++i)
  {
    printf("f(%d)=%d ", i, funcaoX(i));
  }

  printf("\n");

  return 0;
}
