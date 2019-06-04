#include <stdio.h>

#define max(A, B) ((A > B) ? (A) : (B))
#define min(A, B) ((A < B) ? (A) : (B))

int main() 
{
  int x, y, i, j, t, r;

  i = 10;
  j = 20;
  t = -100;
  r = 30;

  x = max(i, j);
  y = min(t, r);

  printf("min:%d max:%d\n", y, x);

  return 0;
}
