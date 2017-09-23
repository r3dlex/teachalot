public static void imprimirDia(Dia dia) {
  switch (dia) { 
    case DOMINGO: System.out.println("Domingo"); break;
    case SEGUNDA: System.out.println("Segunda"); break;
    case TERCA: System.out.println("Terca"); break;
    case QUARTA: System.out.println("Quarta"); break;
    case QUINTA: System.out.println("Quinta"); break;
    case SEXTA: System.out.println("Sexta"); break;
    case SABADO: System.out.println("Sabado"); break;
    default: System.out.println("Dia invalido");
  }
}
