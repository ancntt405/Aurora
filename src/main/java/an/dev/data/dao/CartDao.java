package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.Cart;

public interface CartDao {
	public boolean insert(Cart cart);
    public boolean update(Cart cart);
    public boolean delete(int id);
    public Cart find(int id);
    public List<Cart> findAll();

    Cart findByUserAndProduct(int userId, int productId);

    void updateQuantity(int userId, int productId, int i);
}
