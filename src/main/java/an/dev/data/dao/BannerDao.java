package an.dev.data.dao;

import java.util.List;

import an.dev.data.model.Banner;


public interface BannerDao {
	public boolean insert(Banner banner);
    public boolean update(Banner banner);
    public boolean delete(int id);
    public Banner find(int id);
    public List<Banner> findAll();
}
