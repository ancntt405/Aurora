package an.dev.util;

import an.dev.data.model.OrderItems;

import java.util.List;

public class Helper {
    public static double total(List<OrderItems> orderItemsList) {
        if (orderItemsList == null || orderItemsList.isEmpty()) return 0.0;
        double total = 0.0;
        for (int i = 0; i < orderItemsList.size(); i++) {
            OrderItems ord = orderItemsList.get(i);
            if (ord != null) {
                total += ord.getPrice() * ord.getQuantity();
            }
        }
        return total;
    }
}
