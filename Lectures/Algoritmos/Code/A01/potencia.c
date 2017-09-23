#include <stdio.h>

float potencia(float base, float expoente);  

//Variável global resultado
float resultado;

int main(void)
{
  float base, expoente;

  printf("Base: ");       
  //Lê um valor da entrada de console
  scanf("%f",&base);

  printf("Expoente: ");   
  //Lê um valor da entrada de console
  scanf("%f",&expoente);

  //Chama a função potencia
  resultado = potencia(base,expoente);
  printf("Resposta = %7.2f\n",resultado); 

  //Obtém um caracter antes de sair
  getchar();
}

float potencia(float x, float y)
{
  float resp;
  resp = exp(log(x) * y);
  return(resp);
}
