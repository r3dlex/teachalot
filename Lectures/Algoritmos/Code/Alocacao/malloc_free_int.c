#include <stdio.h>
//NULL
#include <stddef.h>
#include <stdlib.h>
//Se estivermos compilando em Windows
#ifdef _WIN32
//Necessario para o malloc
#include <windows.h>
#endif

int main()
{
  //int* (tipo ponteiro)
  int* um_ponteiro;

  //Aloca um inteiro na memoria dinamica 
  //e retorna o ponteiro para ele
  um_ponteiro = (int*) malloc(sizeof(int));

  //Malloc retorna NULL quando a memoria nao
  //pode ser alocada corretamente
  if (um_ponteiro == NULL)
  {
    printf("Erro: Sem memoria!\n");
    return 1;
  }

  //Coloca o valor 25 no valor apontado
  *um_ponteiro = 25;

  printf("%d\n", *um_ponteiro);

  //Libera a memoria reservada com malloc para
  //ser utilizada conforme necessario
  free(um_ponteiro);

  return 0;
}
