package an.dev.data.model;

import java.sql.Timestamp;

public class Wishlist {
    private int id;
    private int user_id;
    private int product_id;
    private Timestamp created_at;
    private Product product;

    public Wishlist() {
        super();
    }

    public Wishlist(int id, int user_id, int product_id, Timestamp created_at) {
        this.id = id;
        this.user_id = user_id;
        this.product_id = product_id;
        this.created_at = created_at;
    }

    public Wishlist(int user_id, int product_id) {
        this.user_id = user_id;
        this.product_id = product_id;
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

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
