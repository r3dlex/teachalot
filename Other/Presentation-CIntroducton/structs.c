#include "structs.h"

#include <stdio.h>

typedef struct TipoEndereco Endereco;

int main() {
  Endereco ufsc = {
	"s/a",
	0,
	"Trindade",
	"Florianopolis",
	"SC",
	88040900
  };
  
  printf(" Rua: %s, numero %d\
	  \n Bairro: %s\n Cidade: %s, Estado: %s\n CEP: %ld\n",
	  ufsc.rua, ufsc.numero, ufsc.bairro, ufsc.cidade, 
	  ufsc.siglaDoEstado, ufsc.CEP);
	  
  return 0;
}
