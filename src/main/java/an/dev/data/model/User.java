package an.dev.data.model;

import java.sql.Timestamp;

public class User {
   public int id;
   public String email;
   public String password;
   public String phone;
   public String address;
   public String image;
   public Timestamp created_at;
   public Timestamp updated_at;
   public String role;
   public String name;
public User(int id, String email, String password, String phone, String address, String image, Timestamp created_at,
		Timestamp updated_at, String role, String name) {
	super();
	this.id = id;
	this.email = email;
	this.password = password;
	this.phone = phone;
	this.address = address;
	this.image = image;
	this.created_at = created_at;
	this.updated_at = updated_at;
	this.role = role;
	this.name = name;
}
}
