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

}
