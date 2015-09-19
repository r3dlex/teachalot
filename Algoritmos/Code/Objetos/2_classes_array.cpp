#include <iostream>

class Pessoa 
{
public:
	Pessoa(std::string _nome) : _nome(_nome) 
  { }
	
	std::string getNome() 
  { return _nome; }
	
private:
	std::string _nome;
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
