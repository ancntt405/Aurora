package an.dev.data.dao;

import an.dev.data.model.Blog;
import java.util.List;

public interface BlogDao {
    public int insert(Blog blog);
    public boolean update(Blog blog);
    public boolean delete(int id);
    public Blog find(int id);
    public List<Blog> findAll();
}
