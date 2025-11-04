package an.dev.data.dao;

import java.util.List;
import an.dev.data.model.User;

public interface UserDao {
    public boolean insert(User user);
    public boolean update(User user);
    public boolean delete(int id);
    public User find(String id);
    public User find(String email, String password);
    public User findByEmail(String email);
    public User findByPhone(String phone);
    public List<User> findAll();
}
