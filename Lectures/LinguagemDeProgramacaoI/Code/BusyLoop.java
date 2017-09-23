import java.lang.Thread;

public class BusyLoop {
  public static void main(String[] args) {
    while (true) {
      FazerAlgo(); 
      try {
        Thread.sleep(600); //ms
      }
      catch (InterruptException ex) { 
        ex.printStackTrace();
      }
    }
  }
}
