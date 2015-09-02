#include <iostream>

int contador = 0;

class Ave 
{
public:
	Ave(std::string nome)
		: nome(nome)
	{
		std::cout << nome << " criado." << std::endl;
	}
	
	~Ave() 
  {
		std::cout << nome << " destruido." << std::endl;
	}

	void voar() 
  {
		++contador;
	}

private:
	std::string nome;
};

int main() 
{
	std::cout << "----" << std::endl;

	Ave a("Tobi"), b("Rex");
	Ave c("Falcon");

	a.voar();
	c.voar();
	
	std::cout << contador << " aves voaram." << std::endl;

	return 0;
}
