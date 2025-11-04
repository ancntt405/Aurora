package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.OrderItems;


public interface OrderItemDao {
	public boolean insert(OrderItems orderitems);
    public boolean update(OrderItems orderitems);
    public boolean delete(int id);
    public OrderItems find(int id);
    public List<OrderItems> findAll();
    public List<OrderItems> findByOrderId(int orderId);
}
