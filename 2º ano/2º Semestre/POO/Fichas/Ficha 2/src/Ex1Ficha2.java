public class Ex1Ficha2
{
    public int minArray (int[] a)
    {
        int min = a[0];
        int pos = 0;
        for (int i = 1 ; i < a.length; i++)
        { if (a[i] < min)
        {
            min = a[i];
            pos = i;
        }
        }
        return min;
    }
    public int [] arrayEntreInts (int[] a, int o, int f)
    {
        int j = 0;
        int [] array = new int[a.length];
        for (int i = o; i <= f; i++)
        {
            array[j] = a[i];
            j++;
        }
        return array;
    }
}


