public class ArvoreBinaria {
    No raiz;
    int quantidadeDeElementos;
 
    public ArvoreBinaria(int chaveRaiz) {
        raiz = new No(chaveRaiz);
        quantidadeDeElementos = 0;
    }

     /* ... */
 
    public void aceitarVisitante(ArvoreVisitor visitor) {
        visitor.visitar(raiz);
    }
}
