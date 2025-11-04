package an.dev.data.model;

public class Blog {
	public int id;
	public String title;
	public String description;
	public String image_url;
	public Blog(int id, String title, String description, String image_url) {
		super();
		this.id = id;
		this.title = title;
		this.description = description;
		this.image_url = image_url;
	}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }
}
