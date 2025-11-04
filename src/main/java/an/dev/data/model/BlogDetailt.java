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
}
