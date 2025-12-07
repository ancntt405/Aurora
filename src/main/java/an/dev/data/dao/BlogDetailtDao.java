package an.dev.data.dao;

import an.dev.data.model.BlogDetailt;

public interface BlogDetailtDao {
    public int insert(BlogDetailt blogDetailt);
    public boolean update(BlogDetailt blogDetailt);
    public boolean delete(int id);
    public BlogDetailt findByBlogId(int blogId);
}
