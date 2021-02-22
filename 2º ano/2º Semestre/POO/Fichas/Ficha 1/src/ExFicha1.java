public class ExFicha1 {
    public double celciusParaFarenheit (double graus)
    {
        return (graus * 9/5) + 32;
    }

    public int maximoNumeros (int x, int y)
    {
        return (x>y? x:y);
    }

    public String criaDescricaoConta (String nome, double saldo)
    {
        return "Nome: " + nome + ",saldo: " + saldo;
    }

    public double eurosParaLibras(double valor, double taxaConversao)
    {
        return valor*taxaConversao;
    }

    public String doisValores (int valor1, int valor2)
    {
        if (valor1 > valor2) return valor1 + ", " + valor2 + ", " + ((valor1 + valor2)/2);
        else return valor2 + ", " + valor1 + ", " + ((valor1 + valor2)/2);
    }

    public long factorial(int num)
    {
        if (num==1) return 1;
        return num*factorial(num-1);
    }

    public long tempoGasto()
    {
        long i = java.lang.System.currentTimeMillis();
        factorial(5000);
        long j = java.lang.System.currentTimeMillis();
        return j-i;
    }
}
