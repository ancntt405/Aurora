package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.Blog;


public interface BlogDao {
	public boolean insert(Blog blog);
    public boolean update(Blog blog);
    public boolean delete(int id);
    public Blog find(int id);
    public List<Blog> findAll();
}
