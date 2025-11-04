package an.dev.data.model;

public class OrderItems {
    public int id;
    public int quantity;
    public double price;
    public int order_id;
    public int product_id;
	public OrderItems(int id, int quantity, double price, int order_id, int product_id) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.price = price;
		this.order_id = order_id;
		this.product_id = product_id;
	}
}
