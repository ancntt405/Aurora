package an.dev.data.model;

import java.sql.Timestamp;

public class BlogDetailt {
    public int id;
    public int blog_id;
    public String content;
    public Timestamp created_at;
    public Timestamp updated_at;
	public BlogDetailt(int id, int blog_id, String content, Timestamp created_at, Timestamp updated_at) {
		super();
		this.id = id;
		this.blog_id = blog_id;
		this.content = content;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBlog_id() {
        return blog_id;
    }

    public void setBlog_id(int blog_id) {
        this.blog_id = blog_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
}
