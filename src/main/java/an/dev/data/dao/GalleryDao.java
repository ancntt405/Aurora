package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.Gallery;


public interface GalleryDao {
	public boolean insert(Gallery gallery);
    public boolean update(Gallery gallery);
    public boolean delete(int id);
    public Gallery find(int id);
    public List<Gallery> findAll();
    public List<Gallery> findByProductId(int productId);
    public boolean deleteByProduct(int productId);
}
