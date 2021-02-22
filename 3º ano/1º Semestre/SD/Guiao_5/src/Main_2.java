public class Main_2 {
    public static void main(String[] args) throws InterruptedException {
        Warehouse_2 wh = new Warehouse_2();

        wh.addItem("item1");
        wh.addItem("item2");
        wh.addItem("item3");

        Consumer_2 c = new Consumer_2(wh);
        Producer_2 p = new Producer_2(wh);
    }
}
