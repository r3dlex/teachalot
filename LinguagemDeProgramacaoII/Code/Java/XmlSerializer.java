public String escreverXml(List<Mensagem> mensagens) {
  XmlSerializer serializer = Xml.newSerializer();
  StringWriter writer = new StringWriter();
  try {
    serializer.setOutput(writer);
    serializer.startDocument("UTF-8", true);
    serializer.startTag("", "mensagens");
    serializer.attribute("", "numero", String.valueOf(mensagens.size()));
    for (Mensagem msg: mensagens){
      serializer.startTag("", "mensagem");
      serializer.attribute("", "data", msg.getData());
      serializer.startTag("", "titulo");
      serializer.text(msg.getTitulo());
      serializer.endTag("", "titulo");
      serializer.startTag("", "corpo");
      serializer.text(msg.getTexto());
      serializer.endTag("", "corpo");
      serializer.endTag("", "mensagem");
    }
    serializer.endTag("", "mensagens");
    serializer.endDocument();
    return writer.toString();
  } catch (Exception e) {
    throw new RuntimeException(e);
  }
}
