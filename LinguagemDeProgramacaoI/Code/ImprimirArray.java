public class ImprimirArray {
	public static <E> void imprimirArray(E[] array) {
		System.out.print("[");
		for (E elemento : array) {
			System.out.print(" " + elemento);
		}
		System.out.print(" ]\n"); // nova linha 
	}

	public static void main(String[] args) {
		Integer[] arrayDeInt = { 2, 4, 8, 16, 32, 64 }; //int
		imprimirArray(arrayDeInt);
		Double[] arrayDeDouble = { 1.23, 3.21, 1.32, 3.12 }; //double
		imprimirArray(arrayDeDouble);
		Character[] arrayDeChar = { 'O', 'L', 'A', '!' }; // char
		imprimirArray(arrayDeChar);
	}
}
