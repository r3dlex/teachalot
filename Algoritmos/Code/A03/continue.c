#include <stdio.h>

int main ()
{
  int a = 10;

  /* loop */
  do
  {
    if( a == 15)
    {
      /* pula a iteração */
      a = a + 1;
      continue;
    }

    printf("a: %d\n", a);
    a++;

  } while (a < 20);

  return 0;
}
