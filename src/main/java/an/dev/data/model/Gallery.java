package an.dev.data.model;

public class Gallery {
	public int id;
	public String image_url;
	public int product_id;
	public Gallery(int id, String image_url, int product_id) {
		super();
		this.id = id;
		this.image_url = image_url;
		this.product_id = product_id;
	}

}
