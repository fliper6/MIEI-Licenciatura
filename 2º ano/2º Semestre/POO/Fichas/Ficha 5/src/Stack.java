import java.util.ArrayList;
import java.util.List;

public class Stack
{
    private List<String> st;

    public Stack ()
    { this.st = new ArrayList<String>();}

    // Construtor por parâmetros
    public Stack (List <String> elems)
    {
        this.st = new ArrayList<String>();
        for (String s: elems)
            this.st.add(s);
    }

    public Stack (Stack st)
    {
        setSt (st.getSt());
    }

    public List<String> getSt()
    {
        ArrayList<String> a = new ArrayList<> ();
        for (String s: this.st)
            a.add(s);
        return a;
    }

    public void setSt (List<String> elems)
    {
        this.st = new ArrayList<>();
        for (String s: elems)
            this.st.add(s);
    }

    public void push (String s)
    { this.st.add(s);}

    public String top ()
    { return this.st.get (this.st.size()-1); }

    public void pop ()
    { this.st.remove (this.st.size()-1); }

    public boolean empty ()
    { return this.st.isEmpty(); }

    public int length ()
    { return this.st.size(); }

    public Stack clone ()
    { return new Stack(this); }

    public boolean equals (Object o)
    {
        if (o == this) return true;
        if (o == null || o.getClass() != this.getClass())
            return false;
        Stack aux = (Stack)o;
        return aux.getSt().equals(this.st);
    }

    /* STACK APARECE AO CONTRÁRIO: "um dois tres"
    public String toString ()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("Stack: ");
        for (String s: this.st)
            sb.append(s);
        return sb.toString();
    }
    */

    // versão do Hugo, imprime "tres dois um"
    public String toString ()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("Stack: ");
        for (int i = this.st.size()-1; i>=0; i--)
            sb.append(this.st.get(i));
        return sb.toString();
    }



}
