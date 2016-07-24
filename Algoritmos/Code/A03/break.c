#include <stdio.h>

int main ()
{
  int a = 10;

  /* loop */
  while (a < 20)
  {
    printf("a: %d\n", a);
    a++;
    if (a > 15)
    {
      /* termina o loop imediatamente*/
      break;
    }
  }

  return 0;
}
