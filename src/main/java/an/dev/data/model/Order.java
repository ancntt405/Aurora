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
}
