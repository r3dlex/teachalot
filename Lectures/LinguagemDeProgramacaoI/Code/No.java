public class No {
  protected int _chave;
  protected No _esquerdo, _direito;

  public No(int _chave) {
    _chave = _chave;
    _esquerdo = null;
    _direito = null;
  }

  public int getChave() {
    return _chave;
  }

  public No getEsquerdo() {
    return _esquerdo;
  }

  public No getDireito() {
    return _direito;
  }
}
