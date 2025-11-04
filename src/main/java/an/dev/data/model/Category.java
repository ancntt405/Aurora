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

    public Category(String name, String thumbnail, boolean status) {
        super();
        this.name = name;
        this.thumbnail = thumbnail;
        this.status = status;
    }

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

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
