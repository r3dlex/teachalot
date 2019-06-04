#include <stdio.h>  

//Função sem retorno e sem parâmetro
int main(void) 
{
  int dia, mes, ano;

  dia = 14;
  mes = 10;
  ano = 91;

  //Imprime no console mês, dia e ano
  printf("Data: %d/%d/%d\n",dia,mes,ano);

  //Obtém um caracter no terminal e sai
  getchar();

  return 0;
}
