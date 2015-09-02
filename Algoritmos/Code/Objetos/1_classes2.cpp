#include <iostream>

class Roda 
{
public:
	Roda() 
  { }

	Roda(std::string marca, std::string cor)
		: marca(marca), cor(cor)
	{ }
	
	std::string getMarca() const 
  {
		return marca;
	}
	
private:
	std::string marca;
	std::string cor;
};

class Carro 
{
public:
	void montar(Roda roda0, Roda roda1, Roda roda2, Roda roda3) 
  {
		rodas[0] = roda0;
		rodas[1] = roda1;
		rodas[2] = roda2;
		rodas[3] = roda3;
	}

	bool montado() const 
  {
		for (int i = 0; i < 4; ++i) 
    {
			if (rodas[i].getMarca().size() == 0) 
      {
				return false;
			}
		}
		
		return true;
	}

private:
	Roda rodas[4];
};

int main() {
	Carro meuCarro;
	
	std::cout << "Carro esta montado: " << (meuCarro.montado() ? "sim" : "nao") << std::endl;

	meuCarro.montar(
		Roda(std::string("Pirelli"), std::string("Preta")),
		Roda(std::string("Pirelli"), std::string("Preta")),
		Roda(std::string("Pirelli"), std::string("Cinza")),
		Roda(std::string("Pirelli"), std::string("Cinza"))
	);
	
	std::cout << "Carro esta montado: " << (meuCarro.montado() ? "sim" : "nao") << std::endl;

	return 0;
}
