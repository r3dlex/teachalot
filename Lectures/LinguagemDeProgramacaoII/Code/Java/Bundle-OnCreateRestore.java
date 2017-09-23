String _nomeSalvo;

// ... 

@Override
protected void onCreate(Bundle estado) {
  // Estado foi salvo?
  if (estado != null) {
     _nomeSalvo = estado.getString("nome");
  }
}

@Override
public void onSaveInstanceState(Bundle estado) {  
  estado.putString("nome", "LP II");
}

