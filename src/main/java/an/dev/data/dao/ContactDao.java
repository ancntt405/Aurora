package an.dev.data.dao;

import an.dev.data.model.Contact;
import java.util.List;

public interface ContactDao {
    public int insert(Contact contact);
    public boolean update(Contact contact);
    public boolean delete(int id);
    public Contact find(int id);
    public List<Contact> findAll();
    public List<Contact> findByStatus(String status);
}
