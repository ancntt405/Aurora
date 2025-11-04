package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.Order;


public interface OrderDao {
	public boolean insert(Order order);
    public boolean update(Order order);
    public boolean delete(int id);
    public Order find(int id);
    public List<Order> findAll();
}
