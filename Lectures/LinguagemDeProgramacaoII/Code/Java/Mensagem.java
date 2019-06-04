public class Mensagem {
  private String _titulo;
  private String _texto;
  private String _autor;
  private String _data;

  public Mensagem(String titulo, String texto, String autor) {
    _titulo = titulo;
    _texto = texto;
    _autor = autor;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
    _data = sdf.format(new Date());
  }

  public String getData() {
    return _data;
  }

  public String getTitulo() {
    return _titulo;
  }

  public String getAutor() {
    return _autor;
  }

  public String getTexto() {
    return  _texto;
  }
}
