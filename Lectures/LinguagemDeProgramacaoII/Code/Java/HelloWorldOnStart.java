public class HelloWorldActivity extends Activity {
  private static final String TAG = "HelloWorld";
  @Override
  protected void onStart() {
    Log.i(TAG, "onStart");
    super.onStart();
  }
  //...
}
