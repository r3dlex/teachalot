#include <stdio.h>
 
int main ()
{
   /* loop... (a = a +1) eh igual a ++a */
   for (int a = 10; a < 20; a = a + 1)
   {
     printf("a: %d\n", a);
   }

   return 0;
}
