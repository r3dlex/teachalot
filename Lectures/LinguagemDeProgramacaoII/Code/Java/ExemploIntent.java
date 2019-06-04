// Processo o texto para ser transmitido pela rede
String endereco = textoDeEndereco.getText().toString();
endereco = endereco.replace(' ', '+');

// Cria um objeto com a Intencao (Intent) GoogleMaps (geo)
Intent geoIntent = new Intent(
    android.content.Intent.ACTION_VIEW, Uri
    .parse("geo:0,0?q=" + endereco));
