public String escreverXml(List<Mensagem> mensagens) {
  XmlSerializer serializer = Xml.newSerializer();
  StringWriter writer = new StringWriter();
  try {
    // Escrita e retorno...
  } catch (Exception e) {
    throw new RuntimeException(e);
  }
}
