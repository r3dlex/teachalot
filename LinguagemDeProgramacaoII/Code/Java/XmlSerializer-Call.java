List<Mensagem> mensagens = new ArrayList<Mensagem>();
mensagens.add(new Mensagem("Ola", 
      "Ola Mundo!", "n00b"));
mensagens.add(new Mensagem("Android", 
      "Android XML é fácil!", "prof"));
Log.i(TAG, escreverXml(mensagens));
