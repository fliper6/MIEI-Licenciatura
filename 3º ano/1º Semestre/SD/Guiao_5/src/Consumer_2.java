public class Consumer_2 {
    private Warehouse_2 wh;

    public Consumer_2(Warehouse_2 wh) {
        this.wh = wh;
    }

    public void run() {
        String[] items = new String[3];
        items[0] = "item1";
        items[1] = "item2";
        items[2] = "item3";
        this.wh.consume(items);
    }
}
