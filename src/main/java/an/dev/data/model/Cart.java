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

    public Cart() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }
}
