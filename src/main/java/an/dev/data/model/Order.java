package an.dev.data.model;

import java.sql.Timestamp;

public class Order {
	public int id;
	public String code;
	public Boolean status;
	public int user_id;
	public Timestamp created_at;
	public Timestamp updated_at;
	public Order(int id, String code, Boolean status, int user_id, Timestamp created_at, Timestamp updated_at) {
		super();
		this.id = id;
		this.code = code;
		this.status = status;
		this.user_id = user_id;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
