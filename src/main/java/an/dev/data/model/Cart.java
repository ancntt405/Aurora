package an.dev.data.model;

import java.sql.Timestamp;

public class Cart {
   public int id;
   public int user_id;
   public int product_id;
   public int quantity;
   public Timestamp created_at;
public Cart(int id, int user_id, int product_id, int quantity, Timestamp created_at) {
	super();
	this.id = id;
	this.user_id = user_id;
	this.product_id = product_id;
	this.quantity = quantity;
	this.created_at = created_at;
}
}
