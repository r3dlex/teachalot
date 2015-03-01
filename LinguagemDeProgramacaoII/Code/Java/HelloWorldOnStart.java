public class HelloWorldActivity extends Activity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    //Salva o estado da activity
    super.onCreate(savedInstanceState);
    //Organiza a interface da atividade
    setContentView(R.layout.activity_hello_world);
  }
  //...
}
