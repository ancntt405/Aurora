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

    public User(String email, String hashedPassword, String role) {
        super();
        this.email = email;
        this.password = hashedPassword;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User(String email, String password, String phone, String address, String image, Timestamp created_at,
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

    public User(int id, String email, String hashedPassword, String role) {
    super();;
    this.id = id;
    this.email = email;
    this.password = hashedPassword;
    this.role = role;
    }
}
