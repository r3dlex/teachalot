public static void fazerAlgo(int [] num) {
  boolean ocorreuTroca = true;  
  int valorAtual;

  while (ocorreuTroca) {
    ocorreuTroca= false;   

    for(int j = 0;  j < num.length -1;  ++j) {

      if (num[j] < num[j + 1]) {
        valorAtual = num[j];

        num[j] = num[j + 1];
        num[j + 1] = valorAtual;

        ocorreuTroca = true;
      }
    }
  }
}

