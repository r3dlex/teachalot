#include <stdio.h>
 
int main ()
{
   int a = 10;

   /* loop */
   do
   {
     printf("a: %d\n", a);
     a = a + 1; /* ++a */
   } while (a < 20);
 
   return 0;
}
