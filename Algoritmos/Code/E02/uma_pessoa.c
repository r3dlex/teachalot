#include <stdio.h>

struct Pessoa {
    char* nome;
    int idade;
    int altura;
    char* cpf;
};

int main() {
  struct Pessoa uma_pessoa;
  uma_pessoa.nome = "Joaozinho";
  uma_pessoa.idade = 16;
  uma_pessoa.altura = 170;
  uma_pessoa.cpf = "00234567899";

  printf("Tamanho = (%u)\n",  sizeof(uma_pessoa));

  return 0;
}
