package an.dev.data.model;

public class CartItem {
    private OrderItems orderItem;
    private Product product;

    public CartItem(OrderItems orderItem, Product product) {
        this.orderItem = orderItem;
        this.product = product;
    }

    public OrderItems getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(OrderItems orderItem) {
        this.orderItem = orderItem;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
