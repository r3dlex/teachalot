#include <stdio.h>

int main(void)
{ 
  int x, y;

  /* x = 4 bytes */ 
  x = sizeof(float); 
  printf("%d\n%lu\n",x,sizeof(y)); 

  return 0;
}
