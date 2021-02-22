import java.util.Arrays;

public class MainFicha5
{
    public static void main (String[] args)
    {
        Stack st;
        st = new Stack();

        System.out.println("isEmpty: " + st.empty());

        st.push("um ");
        st.push("dois ");

        System.out.println("Top: "   + st.top());

        st.push("tres ");

        System.out.println("Stack: " + st.toString());

        st.pop();

        System.out.println("Stack: " + st.toString());

        String[] elements = new String[] {"um ", "dois "};

        Stack st2 = new Stack(Arrays.asList(elements));

        System.out.println("Iguais?: " + st2.equals(st));

        System.out.println("Clone igual tem de ser igual: " + st.equals(st.clone()));
    }
}

/* Em Haskell:

type Stack a = [a]

empty :: Stack a -> Bool
empty = (==) []

push :: c -> Stack c -> Stack c
puh a s = a:s

top :: Stack c -> c
top = head

pop :: Stack c -> Stack c
pop = tail
*/
