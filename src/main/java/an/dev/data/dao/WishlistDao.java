package an.dev.data.dao;

import an.dev.data.model.Wishlist;
import java.util.List;

public interface WishlistDao {
    public boolean insert(Wishlist wishlist);
    public boolean delete(int userId, int productId);
    public boolean exists(int userId, int productId);
    public List<Wishlist> findByUserId(int userId);
    public int countByUserId(int userId);
}
