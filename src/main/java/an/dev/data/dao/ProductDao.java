package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.Product;


public interface ProductDao {
	public int insert(Product product);
    public boolean update(Product product);
    public boolean delete(int id);
    public Product find(int id);
    public List<Product> findAll();

    List<Product> getProducts(int i, int perPage);

    List<Product> findAllByCategoryId(int categoryId);

    List<Product> relatedProductList(Product products);

    void updateView(Product products);

    List<Product> filter(int categoryId, String property, String order);
}
