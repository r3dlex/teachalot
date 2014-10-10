class BitwiseHex {
    public static void main(String[] args) {
        int mascara = 0x000F; //15
        int valor = 0x22; //34
        System.out.println(valor & mascara); //and
        System.out.println(valor | mascara); //or
        System.out.println(valor ^ mascara); //xor
    }
}
