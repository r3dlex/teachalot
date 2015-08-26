#include <iostream>
// Inclusao do header set
#include <set>

int main() 
{
  std::set<std::string> s;

  // Adicionamos duas vezes Ola Mundo ao conjunto
  s.insert("Ola");
  s.insert("Mundo");
  s.insert("Ola");
  s.insert("Mundo");

  std::cout << "std::set =";
  //auto = reconheca o tipo automaticamente (C++13)
  for (auto it = s.begin(); it != s.end(); ++it)
  {
    std::cout << ' ' << *it;
  }
  std::cout << std::endl;

  return 0;
}
