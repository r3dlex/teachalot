public class VisitanteEmOrdem implements VisitanteDeArvore {
    @Override
    public void visitar(No no) {
        if (no == null)
            return;
        this.visitar(no.getEsquerdo());
        System.out.println(no);
        this.visitar(no.getDireito());
    }
}
