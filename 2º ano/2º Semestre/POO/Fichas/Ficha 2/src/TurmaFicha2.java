public class TurmaFicha2 {
        private int [][] notasTurma; //fora desta classe não podemos aceder a esta variável
        public Ficha2_Turma(int [][] t) //criar várias instâncias para as várias UCs
        {                               //o construtor tem que ter o mesmo nome que a classe
            notasTurma = t;
        }
        public int somaNotas (int uc)
        {
            int soma = 0;
            for (int i = 0; i < notasTurma.length; i++)
                soma += notasTurma[i][uc];
            return soma;
        }
        public int mediaNotas (int aluno)
        {
            int soma = 0;
            int i;
            for (i = 0; i < notasTurma[aluno].length; i++)
                soma += notasTurma[aluno][i];
            return (soma/i);
        }
        public int mediaUC (int uc)
        {
            int soma = 0;
            int i;
            for (i = 0; i < notasTurma.length; i++)
                soma += notasTurma[i][uc];
            return (soma/i);
        }
        public int maxNotas (int [][] turma)
        {
            int max = 0;
            for (int i = 0; i < notasTurma.length; i++)
                for (int j = 0; j < notasTurma[i].length; j++)
                {
                    if (max < notasTurma[i][j]) max = notasTurma[i][j];
                }
            return max;
        }
        public int mixNotas (int [][] turma)
        {
            int min = 0;
            for (int i = 0; i < notasTurma.length; i++)
                for (int j = 0; j < notasTurma[i].length; j++)
                {
                    if (min > notasTurma[i][j]) min = notasTurma[i][j];
                }
            return min;
        }
        public int [] notasAcimaDe (int [][] turma, int ref)
        {
            int [] notasAcima = new int[100000];
            int r = 0;
            for (int i = 0; i < notasTurma.length; i++)
                for (int j = 0; j < notasTurma[i].length; j++)
                {
                    if (ref < notasTurma[i][j]) notasAcima[r] = notasTurma[i][j];
                }
            return notasAcima;
        }



}
