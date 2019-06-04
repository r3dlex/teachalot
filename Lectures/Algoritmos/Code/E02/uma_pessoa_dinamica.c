struct Pessoa* Pessoa_criar() {
  struct Pessoa* pessoa = malloc(sizeof(struct Pessoa));
  return pessoa;
}

void Pessoa_destruir(struct Pessoa* uma_pessoa) {
  free(uma_pessoa);
}

struct Pessoa* Pessoa_criarArray(int n) {
  struct Pessoa* pessoas = malloc(sizeof(struct Pessoa) * n);
  return pessoas;
}
