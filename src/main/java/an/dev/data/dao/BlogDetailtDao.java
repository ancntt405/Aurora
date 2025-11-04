package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.BlogDetailt;


public interface BlogDetailtDao {
	public boolean insert(BlogDetailt blogdetailt);
    public boolean update(BlogDetailt blogdetailt);
    public boolean delete(int id);
    public BlogDetailt find(int id);
    public List<BlogDetailt> findAll();
}
