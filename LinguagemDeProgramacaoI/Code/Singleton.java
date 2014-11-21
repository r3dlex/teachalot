public class Singleton {
	private static Singleton instancia;

	private Singleton() {}

	public static synchronized Singleton getSingleton() {
		if (instancia == null)
			instancia = new Singleton();

		return instancia;
	}
}
