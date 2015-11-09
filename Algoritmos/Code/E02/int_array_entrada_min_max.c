#include <stdio.h>
#include <stdlib.h>

#define NUMERO_DE_INTEIROS 10

int main(int argc, char *argv[])
{
  int array_int[NUMERO_DE_INTEIROS];
  int mode[NUMERO_DE_INTEIROS][2];
  printf("Entre com %d inteiros separados por espaço:", NUMERO_DE_INTEIROS);
  scanf("%d %d %d %d %d %d %d %d %d %d",
      &array_int[0], &array_int[1], &array_int[2], 
      &array_int[3], &array_int[4], &array_int[5],
      &array_int[6], &array_int[7],&array_int[8],
      &array_int[9]);

  int i ,j,temp;
  //sort array_intay to find max and min values
  for(i=0;i<NUMERO_DE_INTEIROS;i++)
    for(j=9;j>i;j--)
      if(array_int[j]<array_int[j-1]) {
        int temp=array_int[j];
        array_int[j]=array_int[j-1];
        array_int[j-1]=temp;
      }                   

  printf("Max=%d,Min=%d",array_int[9],array_int[0]);
  printf("\n");
  //initialize 2D array_intay storing numbers of occurences, and values
  for(i=0;i<2;i++)
    for(j=0;j<NUMERO_DE_INTEIROS;j++)mode[j][i]=0;
  mode[0][0]=1;

  //find mode
  for(i=0;i<NUMERO_DE_INTEIROS;i++) {
    for(j=0;j<NUMERO_DE_INTEIROS;j++)
      if(array_int[i] == array_int[j+1]) {
        ++mode[i][0];
        mode[i][1] = array_int[i];
      }
  }

  //find max occurence
  int max;
  int k=0;
  max=mode[0][0];
  for(j=0;j<NUMERO_DE_INTEIROS;j++)
    if(max<mode[j][0]){max=mode[j][0];k=j;}

  //print result
  printf("The most occuring item:%d",mode[k][1]);printf("\n");
  printf("It occurs %d",max); printf("times.");
  printf("\n");
  system("PAUSE");

  return EXIT_SUCCESS;
}
