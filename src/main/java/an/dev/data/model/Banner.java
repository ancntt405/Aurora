package an.dev.data.model;

public class Banner {
  public int id;
  public String image;
  public String title;
  public Boolean status;
public Banner(int id, String image, String title, Boolean status) {
	super();
	this.id = id;
	this.image = image;
	this.title = title;
	this.status = status;
}

    public Banner(String safeFileName, String title, boolean status) {
    super();
    this.image = safeFileName;
    this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
