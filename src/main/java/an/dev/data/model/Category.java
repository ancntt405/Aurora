package an.dev.data.model;

public class Category {
	public int id;
	public String name;
	public String thumbnail;
	public Boolean status;
	public Category(int id, String name, String thumbnail, Boolean status) {
		super();
		this.id = id;
		this.name = name;
		this.thumbnail = thumbnail;
		this.status = status;
	}

}
