package an.dev.data.dao;

import an.dev.data.model.BlogDetailt;
import java.util.List;

public interface BlogDetailtDao {
    public int insert(BlogDetailt blogDetailt);
    public boolean update(BlogDetailt blogDetailt);
    public boolean delete(int id);
    public boolean deleteByBlogId(int blogId);
    public BlogDetailt findByBlogId(int blogId);
    public BlogDetailt find(int id);
    public List<BlogDetailt> findAll();
}
