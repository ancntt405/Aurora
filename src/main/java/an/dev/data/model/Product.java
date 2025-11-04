package an.dev.data.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
   public int id;
   public String name;
   public String image;
   public String description;
   public double price;
   public double price_old;
   public int quantity;
   public int view;
   public int category_id;
   public Timestamp created_at;
   public Boolean status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getPrice_old() {
        return price_old;
    }

    public void setPrice_old(double price_old) {
        this.price_old = price_old;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getView() {
        return view;
    }

    public void setView(int view) {
        this.view = view;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public BigDecimal getDiscountAmount() {
        if (price_old <= 0 || price_old <= price) return BigDecimal.ZERO;
        return BigDecimal.valueOf(price_old - price).multiply(BigDecimal.valueOf(1000));
    }
    public int getDiscountPercent() {
        if (price_old <= 0 || price_old <= price) return 0;
        double pct = (1.0 - (double) price / (double) price_old) * 100.0;
        return (int) Math.round(pct);
    }

    public Product(int id, String name, String image, String description, double price, double price_old, int quantity,
                   int view, int category_id, Timestamp created_at, Boolean status) {
	super();
	this.id = id;
	this.name = name;
	this.image = image;
	this.description = description;
	this.price = price;
	this.price_old = price_old;
	this.quantity = quantity;
	this.view = view;
	this.category_id = category_id;
	this.created_at = created_at;
	this.status = status;
}

    public Product(String name, String image, String description, double price, double price_old, int quantity,
                   int view, int category_id, Timestamp created_at, Boolean status) {
        super();
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.price_old = price_old;
        this.quantity = quantity;
        this.view = view;
        this.category_id = category_id;
        this.created_at = created_at;
        this.status = status;
    }
}
