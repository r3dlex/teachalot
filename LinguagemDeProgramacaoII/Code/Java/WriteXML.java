final String xmlFile = "userData";
String userNAme = "username";
String password = "password";
try {
  FileOutputStream fos = new  FileOutputStream("userData.xml");
  FileOutputStream fileos= getApplicationContext().openFileOutput(xmlFile, Context.MODE_PRIVATE);
  XmlSerializer xmlSerializer = Xml.newSerializer();              
  StringWriter writer = new StringWriter();
  xmlSerializer.setOutput(writer);
  xmlSerializer.startDocument("UTF-8", true);
  xmlSerializer.startTag(null, "userData");
  xmlSerializer.startTag(null, "userName");
  xmlSerializer.text(username_String_Here);
  xmlSerializer.endTag(null, "userName");
  xmlSerializer.startTag(null,"password");
  xmlSerializer.text(password_String);
  xmlSerializer.endTag(null, "password");             
  xmlSerializer.endTag(null, "userData");
  xmlSerializer.endDocument();
  xmlSerializer.flush();
  String dataWrite = writer.toString();
  fileos.write(dataWrite.getBytes());
  fileos.close();
}
catch (FileNotFoundException e) {
  TODO Auto-generated catch block
    e.printStackTrace();
}
catch (IllegalArgumentException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
}
catch (IllegalStateException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
}
catch (IOException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
}}}}}
