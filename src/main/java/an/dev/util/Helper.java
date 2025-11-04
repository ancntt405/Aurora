package an.dev.util;

import an.dev.data.model.OrderItems;

import java.util.List;

public class Helper {
    public static double total(List<OrderItems> orderItemsList) {
        double total = 0;
        for (int i = 0; i < orderItemsList.size(); i++) {
            OrderItems ord = orderItemsList.get(0);
            total += ord.getPrice() * ord.getQuantity();

        }
        return total;
    }
}
