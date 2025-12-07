package an.dev.data.dao;

import java.util.List;
import an.dev.data.model.Perfume;

public interface PerfumeDao {
    public int insert(Perfume perfume);
    public boolean update(Perfume perfume);
    public boolean delete(int id);
    public Perfume find(int id);
    public List<Perfume> findAll();
    public List<Perfume> getPerfumes(int page, int perPage);
    public List<Perfume> findByBrand(String brand);
    public List<Perfume> findByGender(String gender);
    public List<Perfume> findByScentType(String scentType);
    public void updateView(Perfume perfume);
}
