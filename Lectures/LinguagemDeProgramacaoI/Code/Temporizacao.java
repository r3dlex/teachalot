import java.util.Timer;
import java.util.TimerTask;

public class Temporizacao {
	public static void main(String[] args) {
		int delay = 2000; // 2000ms
		int interval = 1000; // 1000ms
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			public void run() {
				System.out.println("Deu tempo!");
			}
		}, delay, interval);
	}
}
