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

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
