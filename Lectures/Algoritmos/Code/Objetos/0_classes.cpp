#include <iostream>

class Passaro 
{
public:
  static int CONTADOR;

	Passaro(std::string nome)
		: nome(nome)
	{
		std::cout << nome << " criado." << std::endl;
	}
	
	~Passaro() 
  {
		std::cout << nome << " destruido." << std::endl;
	}

	void voar() 
  {
		++CONTADOR;
	}

private:
	std::string nome;
};

int Passaro::CONTADOR = 0;

int main() 
{
	std::cout << "----" << std::endl;

	Passaro a("Tobi"), b("Rex");
	Passaro c("Falcon");

	a.voar();
	c.voar();
	
	std::cout << Passaro::CONTADOR << " aves voaram." << std::endl;

	return 0;
}
