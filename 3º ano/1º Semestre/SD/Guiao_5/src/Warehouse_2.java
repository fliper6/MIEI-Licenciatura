import java.util.HashMap;

public class Warehouse_2 {
    private HashMap<String, Item_2> stock;

    public Warehouse_2() {this.stock = new HashMap<String, Item_2>();}

    //isto funciona porque estamos a garantir que só há 3 items que são introduzidos no início da main
    //não há introdução nem remoção de items depois
    public void addItem(String item) {
        if (!this.stock.containsKey(item)){
            this.stock.put(item,new Item_2());
        }
    }

    void supply(String item, int quantity){
        this.stock.get(item).supply(quantity);
    }

    void consume(String[] items){
        for (int i = 0; i < items.length; i++){
            System.out.println("Consumer: a consumir "+items[i]);
            this.stock.get(items[i]).consume(); //e o lock fora o que nos garante
            System.out.println("Consumer: consumi "+items[i]);
        }
    }
}
