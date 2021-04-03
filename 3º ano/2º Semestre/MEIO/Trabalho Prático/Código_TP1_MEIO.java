import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Meio {
    /**
     * Para cada filial, retorna a matriz de transição respetiva (13x13) para o caso base de não existirem transações entre as filiais.
     * @param pedidos probabilidade de pedidos para 0...12 clientes
     * @param entregas probabilidade de entregas para 0...12 clientes
     * @return matriz de transição 13x13 para uma filial
     */
    private static double[][] filialTransicao(double[] pedidos, double[] entregas){
        int i,j,x,y;
        double prob,sum;
        double[][] probs = new double[13][13];

        for(i = 0; i<13;i++){
            for(j=0; j<13; j++){
                prob = 0;
                probs[i][j] = 0;
                sum=0;

                for(x = i>=j ? 0 : j-i,y = i>=j ? i-j : 0; x <= j-1 && y <= i-1 ; x++, y++){
                    prob += entregas[x]*pedidos[y];
                }

                for(x=i; x<13; x++){
                    sum+=pedidos[x];
                }
                prob+=sum*entregas[j];

                if(j==12) {
                    for(x=0; x<i ; x++) {
                        sum = 0;
                        for (y = j - i + x + 1; y < 13; y++)
                            sum += entregas[y];
                        prob += pedidos[x] * sum;
                    }
                }

                probs[i][j] = prob;
            }
        }
        return probs;
    }

    /**
     * Junta as duas matrizes de transição de ambas as filiais numa de 169x169
     * @param filial1 matriz de transição calculada para a primeira filial
     * @param filial2 matriz de transição calculada para a segunda filial
     * @return matriz 169x169 com a junção de ambas as filiais relativas a uma transferência
     */
    private static double[][] juntaTransicoesFiliais(double[][] filial1, double[][] filial2){
        double[][] r = new double[169][169];
        for (int i = 0; i < 169; i++)
            for (int j = 0; j < 169; j++)
                r[i][j] = filial1[i / 13][j / 13] * filial2[i % 13][j % 13];
        return r;
    }

    /**
     * Efetua a transferência entre as duas filiais, que são os seguintes casos: +0/-0, +1/-1, +2/-2, +3/-3, -1/+1, -2/+2, -3/+3
     * @param filial1 matriz 13x13 do caso inicial (+0/-0) da filial 1
     * @param filial2 matriz 13x13 do caso inicial (+0/-0) da filial 2
     * @param troca Transferir/Receber de 1,2 ou 3 carros: se for negativo, transferem-se da filial 1 para a 2, se for positivo é o contrário
     * @return lista com as novas matrizes resultantes das transferências
     */
    private static double[][][] transfereEntreFiliais(double[][] filial1, double[][] filial2, int troca){
        int i,j,x = 0,indice;
        double[][] m1 = new double[13][13];
        double[][] m2 = new double[13][13];
        double[][][] r = {m1,m2};

        if(troca<0){
            indice = Math.abs(troca);
            for(i = 0; i < indice; i++){
                for(j = 0; j < 13; j++){
                    m1[i][j] = m2[12-i][j] = 999999;
                }
            }
            for(i = indice; i < 13; i++){
                for(j = 0; j < 13; j++){
                    m1[i][j] = filial1[x][j];
                    m2[x][j] = filial2[i][j];
                }
                x++;
            }
        }
        else if(troca>0){
            for(i = 0; i < troca; i++){
                for(j = 0; j < 13; j++){
                    m1[12-i][j] = m2[i][j] = 999999;
                }
            }
            for(i = troca; i < 13; i++){
                for(j = 0; j < 13; j++){
                    m1[x][j] = filial1[i][j];
                    m2[i][j] = filial2[x][j];
                }
                x++;
            }
        }
        return r;
    }

    /**
     * Grava toda a matriz de transição 169x169 resultante da junção das duas matrizes de transição de ambas as filiais num ficheiro Excel
     * @param transicoes são as 7 Matrizes 169x169 de transição resultante da junção das duas matrizes de transição de ambas as filiais
     * @param contribuicoes são as 7 Matrizes 169x169 de contribuições resultante da junção das duas matrizes de transição de ambas as filiais
     * @param ficheiro nome a dar ao ficheiro
     */
    private static void gravaTransicoesExcel(List<double[][]> transicoes, List<double[][]> contribuicoes, String ficheiro) throws Exception {
        File file = new File("./"+ficheiro);
        file.createNewFile();
        FileOutputStream fos;
        XSSFWorkbook wb = new XSSFWorkbook();
        List<XSSFSheet> tsheets = new ArrayList<>();
        List<XSSFSheet> csheets = new ArrayList<>();
        XSSFSheet sh;
        Row row;
        Cell cell;
        tsheets.add(wb.createSheet("Transicao 0|0"));
        tsheets.add(wb.createSheet("Transicao -3|+3"));
        tsheets.add(wb.createSheet("Transicao -2|+2"));
        tsheets.add(wb.createSheet("Transicao -1|+1"));
        tsheets.add(wb.createSheet("Transicao +1|-1"));
        tsheets.add(wb.createSheet("Transicao +2|-2"));
        tsheets.add(wb.createSheet("Transicao +3|-3"));

        csheets.add(wb.createSheet("Contribuicao 0|0"));
        csheets.add(wb.createSheet("Contribuicao -3|+3"));
        csheets.add(wb.createSheet("Contribuicao -2|+2"));
        csheets.add(wb.createSheet("Contribuicao -1|+1"));
        csheets.add(wb.createSheet("Contribuicao +1|-1"));
        csheets.add(wb.createSheet("Contribuicao +2|-2"));
        csheets.add(wb.createSheet("Contribuicao +3|-3"));

        for(int t = 0; t < 7; t++){
            sh = wb.getSheetAt(t);
            for(int i = 0; i < 169; i++){
                row = sh.createRow(i);
                for(int j = 0; j < 169; j++){
                    cell = row.createCell(j);
                    cell.setCellValue(transicoes.get(t)[i][j]);
                }
            }
        }

        for(int t = 0; t < 7; t++){
            sh = wb.getSheetAt(t+7);
            for(int i = 0; i < 169; i++){
                row = sh.createRow(i);
                for(int j = 0; j < 169; j++){
                    cell = row.createCell(j);
                    cell.setCellValue(contribuicoes.get(t)[i][j]);
                }
            }
        }

        fos = new FileOutputStream(file);
        wb.write(fos);
        fos.close();
    }

    /**
     * Calcula as contribuições base para ambas as filiais
     * @param pedidos probabilidade de pedidos para 0...12 clientes
     * @param entregas probabilidade de entregas para 0...12 clientes
     * @return matrix 13x13 com as contribuições para uma filial
     */
    private static double[][] calculaContribuiçoes(double[] pedidos, double[] entregas){
        int i,j,x,y;
        double sum;
        double[][] r = new double[13][13];

        for(i = 0; i<13;i++){
            for(j=0; j<13; j++){
                r[i][j] = 0;
                sum=0;
                for(x=i>=j?0:j-i, y=i>=j?i-j:0;x<=j-1 && y <= i-1;x++, y++ ){
                    r[i][j] += entregas[x]*pedidos[y]*30*y;
                }
                for(x=i ; x<13; x++ ){
                    sum+=pedidos[x];
                }
                r[i][j] += sum*i*30 * entregas[j];
                if(j>8){
                    r[i][j]-=10;
                }
                if(j==12) {
                    for(x=0; x<i ; x++) {
                        sum = 0;
                        for (y = j - i + x + 1; y < 13; y++)
                            sum += entregas[y];
                        r[i][j] += pedidos[x] * sum * x * 30;
                    }
                }
            }
        }
        return r;
    }

    /**
     * Junta as contribuições de duas filiais numa matriz 169x169
     * @param filial1 contribuições da filial 1
     * @param filial2 contribuições da filial 2
     * @param troca total a retirar por causa do número de trocas
     * @return matriz 169x169 com as contribuições
     */
    private static double[][] juntaContribuicoes(double[][] filial1, double[][] filial2, int troca){
        int retira = Math.abs(troca)*7;
        double[][] r = new double[169][169];
        for(int i = 0; i < 169; i++){
            for (int j = 0; j < 169; j++) {
                r[i][j] = filial1[i / 13][j / 13] + filial2[i % 13][j % 13] - retira;
            }
        }
        return r;
    }

    /**
     * Efetua o cálculo das matrizes de contribuição resultantes das transferências entre as duas filiais, que são os seguintes casos: +0/-0, +1/-1, +2/-2, +3/-3, -1/+1, -2/+2, -3/+3
     * @param filial1 matriz 13x13 do caso inicial (+0/-0) da filial 1
     * @param filial2 matriz 13x13 do caso inicial (+0/-0) da filial 2
     * @param troca Transferir/Receber de 1,2 ou 3 carros: se for negativo, transferem-se da filial 1 para a 2, se for positivo é o contrário
     * @return lista com as novas matrizes de contribuição resultantes das transferências
     */
    private static double[][][] contribuicoesTransferencia(double[][] filial1, double[][] filial2, int troca){
        int i,j,x = 0,indice;
        double[][] m1 = new double[13][13];
        double[][] m2 = new double[13][13];
        double[][][] r = {m1,m2};
        if(troca<0){
            indice = Math.abs(troca);
            for(i = 0; i < indice; i++){
                for(j = 0; j < 13; j++){
                    m1[i][j] = m2[12-i][j] = -999999;
                }
            }
            for(i = indice; i < 13; i++){
                for(j = 0; j < 13; j++){
                    m1[i][j] = filial1[x][j];
                    m2[x][j] = filial2[i][j];
                }
                x++;
            }
        }
        else if(troca>0){
            for(i = 0; i < troca; i++){
                for(j = 0; j < 13; j++){
                    m1[12-i][j] = m2[i][j] = -999999;
                }
            }
            for(i = troca; i < 13; i++){
                for(j = 0; j < 13; j++){
                    m1[x][j] = filial1[i][j];
                    m2[i][j] = filial2[x][j];
                }
                x++;
            }
        }
        return r;
    }

    /**
     * Realiza o processo iterativo para obter o resultado final
     * @param n Número de iterações a realizar
     * @param k Número de transições possíveis
     * @param transicoes As K matrizes de transição 169x169
     * @param contribuicoes as K matrizes de contribuições 169x169
     */
    private static void converge(int n, int k, List<double[][]> transicoes, List<double[][]> contribuicoes){
        int f = 0, indice;
        double sum, max;
        List<double[]> q = new ArrayList<>();
        List<double[]> v;
        double[] aux;
        double[] f_ant;
        double[] f_atual = new double[169];
        double[] d = new double[169];
        double[] aux2 = new double[k];
        int[] decisao = new int[169];

        for(int x = 0; x < k; x++){ // calculo das esperanças Q %% NAO MEXER %%
            aux = new double[169];
            for(int i = 0; i < 169; i++){
                for (int j = 0; j < 169; j++) {
                    aux[i] += contribuicoes.get(x)[i][j] * transicoes.get(x)[i][j];
                }
            }
            q.add(aux);
        }

        for(int it = 0; it < n; it++){ // para as 50 iteraçoes
            f_ant = Arrays.copyOf(f_atual,169);
            v = new ArrayList<>();
            for(int x = 0; x < k; x++){ // para os k = 7
                aux = new double[169];
                for(int i = 0; i < 169; i++){ // para a matriz P^K
                    sum=0;
                    for(int j = 0; j < 169; j++){
                        sum+= transicoes.get(x)[i][j] * f_ant[j];
                    }
                    aux[i] = sum + q.get(x)[i];
                }
                v.add(aux);
            }
            for(int y = 0; y < 169; y++){
                for(int x = 0; x < k; x++){
                    aux2[x] = v.get(x)[y];
                }
                indice = 0;
                max = -999999;
                for(int i = 0; i < k; i++){
                    if(aux2[i] > max){
                        max = aux2[i];
                        indice = i;
                    }
                }
                f_atual[y] = max;
                if(it==n-1) decisao[f++]=indice;
            }
            for(int i = 0; i < 169; i++){
                d[i] = f_atual[i] - f_ant[i];
            }
        }
        for(int i = 0; i < 169; i++){
            System.out.print(d[i] + ","); // para mostrar a convergência final
        }
        System.out.println();
        for(int i = 0; i < 13; i++){
            System.out.print("Linha " + i + ": ");
            for(int j = 0; j < 13; j++){
                System.out.print(decisao[13*i+j] + ", ");
            }
            System.out.println();
        }

    }

    public static void main(String... args) throws Exception{
        double[] pedidos1 = {0.0476 , 0.1388 , 0.2252 , 0.2260 , 0.1644 , 0.1044 , 0.0564 , 0.0240 , 0.0100 , 0.0024 , 0.0004 , 0.0004 , 0.0000};
        double[] entregas1 = {0.0412 , 0.0908 , 0.1092 , 0.1332 , 0.1376 , 0.1180 , 0.1092 , 0.0832 , 0.0612 , 0.0448 , 0.0380 , 0.0244 , 0.0092};
        double[] pedidos2 = {0.0444 , 0.0992 , 0.1288 , 0.1444 , 0.1224 , 0.1068 , 0.0968 , 0.0792 , 0.0612 , 0.0488 , 0.0364 , 0.0220 , 0.0096};
        double[] entregas2 = {0.0280 , 0.0656 , 0.0904 , 0.1320 , 0.1508 , 0.1268 , 0.1124 , 0.0928 , 0.0720 , 0.0608 , 0.0356 , 0.0240 , 0.0088};

        double[][] transicao1 = filialTransicao(pedidos1,entregas1);
        double[][] transicao2 = filialTransicao(pedidos2,entregas2);
        double[][] cont1 = calculaContribuiçoes(pedidos1,entregas1);
        double[][] cont2 = calculaContribuiçoes(pedidos2,entregas2);
        double[][] contJuntas;
        double[][] transJuntas;
        double[][][] transita;
        double[][][] contribui;
        List<double[][]> gravarTransicoes = new ArrayList<>();
        List<double[][]> gravarContribuicoes = new ArrayList<>();
        gravarTransicoes.add(juntaTransicoesFiliais(transicao1,transicao2));
        gravarContribuicoes.add(juntaContribuicoes(cont1,cont2,0));
        for(int troca = 3; troca > -4; troca--){
            if(troca!=0){
                transita = transfereEntreFiliais(transicao1,transicao2,troca);
                contribui = contribuicoesTransferencia(cont1,cont2,troca);

                transJuntas = juntaTransicoesFiliais(transita[0],transita[1]);
                contJuntas = juntaContribuicoes(contribui[0], contribui[1],troca);

                gravarTransicoes.add(transJuntas);
                gravarContribuicoes.add(contJuntas);
            }
        }
        gravaTransicoesExcel(gravarTransicoes,gravarContribuicoes,"matrizes.xlsx");
        converge(25,7,gravarTransicoes,gravarContribuicoes);
    }
}

