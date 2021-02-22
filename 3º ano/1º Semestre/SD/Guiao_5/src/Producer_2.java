import java.util.ArrayList;

public class Producer_2 {
    private Warehouse_2 wh;

    public Producer_2(Warehouse_2 wh) {
        this.wh = wh;
    }

    public void run() {
        ArrayList<String> items = new ArrayList<>();
        items.add("item1");
        items.add("item2");
        items.add("item3");

        for (String s: items) {
            this.wh.supply(s,1);
            try {
                Thread.sleep(3);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
