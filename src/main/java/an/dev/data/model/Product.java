package an.dev.data.model;

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
}
