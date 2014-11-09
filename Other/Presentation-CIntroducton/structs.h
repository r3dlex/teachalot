#ifndef ENDERECO_H_
#define ENDERECO_H_

struct TipoEndereco {
    char rua[50];
    int numero;
    char bairro[50];
    char cidade[50];
    char siglaDoEstado[2];
    long int CEP;
}; 

#endif