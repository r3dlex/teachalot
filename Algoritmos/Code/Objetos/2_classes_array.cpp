#include <iostream>

class Pessoa 
{
public:
	Pessoa(std::string nome) : nome(nome) 
  { }
	
	std::string getNome() 
  { return nome; }
	
private:
	std::string nome;
};

int main() 
{
	Pessoa pessoas[4] = 
  {
		Pessoa("Julio"),
		Pessoa("Gustavo"),
		Pessoa("Matheus"),
		Pessoa("Guilherme")
	};
	
	for (int i = 0; i < 4; ++i) 
  {
		std::cout << pessoas[i].getNome() << std::endl;
	}	

	return 0;
}
