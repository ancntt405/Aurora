package an.dev;
import an.dev.data.model.*;
import java.util.List;

public interface DataProvider {
    /**
     * Lấy danh sách categories
     * @return List<Category>
     */
    List<Category> getCategories();

    /**
     * Lấy danh sách banners
     * @return List<Banner>
     */
    List<Banner> getBanners();
    /**
     * Lấy danh sách products
     * @return List<Products>
     */
    List<Product> getProducts();

    /**
     * Lấy danh sách hot products (sản phẩm nổi bật)
     * @return List<Products>
     */
    List<Product> getHotProducts();

    /**
     * Lấy danh sách new products (sản phẩm mới)
     * @return List<Products>
     */
    List<Product> getNewProducts();

    /**
     * Lấy danh sách hot categories (danh mục nổi bật)
     * @return List<Category>
     */
    List<Category> getHotCategories();
}
