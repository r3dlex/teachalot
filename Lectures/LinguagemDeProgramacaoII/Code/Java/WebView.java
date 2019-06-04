  _webview = (WebView) findViewById(R.id.webview);
  _webview.setWebViewClient(new ClienteWeb());
  _webview.getSettings().setJavaScriptEnabled(true);
  _webview.loadUrl("http://www.cesusc.edu.br");
  //...

  private class ClienteWeb extends WebViewClient {
    //...
    @Override
    public boolean shouldOverrideUrlLoading(WebView view, 
        String url) {

      Log.i(TAG, "Carregando:" + url);
      view.loadUrl(url);
      return true;
    }
  }
