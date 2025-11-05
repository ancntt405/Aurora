package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.model.Product;
import an.dev.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
public class ShopServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        ProductDao productsDao = DatabaseDao.getInstance().getProductDao();
        List<Product> productsList = productsDao.findAll();


        // lọc sản phẩm theo category_id
        String catParam = request.getParameter("categoryId");
        if (catParam != null && !catParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(catParam);
                // Ưu tiên lọc phía máy chủ thông qua DAO để tránh dữ liệu cũ
                List<Product> filtered = productsDao.findAllByCategoryId(categoryId);
                productsList = filtered;
                request.setAttribute("selectedCategoryId", categoryId);
            } catch (NumberFormatException ignored) {
                // Bỏ qua categoryId không hợp lệ, quay lại danh sách đầy đủ
            }
        }

        // lọc theo giá tối đa (priceMax) nếu có
        String priceMaxParam = request.getParameter("priceMax");
        if (priceMaxParam != null && !priceMaxParam.isEmpty()) {
            try {
                double priceMax = Double.parseDouble(priceMaxParam);
                java.util.List<Product> filteredByPrice = new java.util.ArrayList<>();
                for (Product p : productsList) {
                    if (p.getPrice() <= priceMax) {
                        filteredByPrice.add(p);
                    }
                }
                productsList = filteredByPrice;
                request.setAttribute("priceMax", priceMax);
            } catch (NumberFormatException ignored) {
              
            }
        }

        // lọc theo từ khóa q nếu có (tìm trong tên, không phân biệt hoa thường)
        String q = request.getParameter("q");
        if (q != null && !q.trim().isEmpty()) {
            String key = q.trim().toLowerCase();
            java.util.List<Product> filteredByKey = new java.util.ArrayList<>();
            for (Product p : productsList) {
                String name = p.getName() != null ? p.getName().toLowerCase() : "";
                if (name.contains(key)) filteredByKey.add(p);
            }
            productsList = filteredByKey;
            request.setAttribute("q", q);
        }

        String sort = request.getParameter("sort");
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "price_asc":
                    productsList.sort(java.util.Comparator.comparingDouble(Product::getPrice));
                    break;
                case "price_desc":
                    productsList.sort(java.util.Comparator.comparingDouble(Product::getPrice).reversed());
                    break;
                case "name_asc":
                    productsList.sort(java.util.Comparator.comparing(Product::getName, java.text.Collator.getInstance()));
                    break;
                case "newest":
                    productsList.sort((a,b) -> Integer.compare(b.getId(), a.getId()));
                    break;
            }
            request.setAttribute("sort", sort);
        }
        int page = 1;
        try { if (request.getParameter("page") != null) page = Integer.parseInt(request.getParameter("page")); } catch (NumberFormatException ignored) {}
        if (page < 1) page = 1;
        int total = productsList.size();
        int numberPage = (int) Math.ceil((double) total / (double) Constants.PER_PAGE);
        if (numberPage <= 0) numberPage = 1;
        if (page > numberPage) page = numberPage;
        int from = Math.min((page - 1) * Constants.PER_PAGE, total);
        int to = Math.min(from + Constants.PER_PAGE, total);
        List<Product> pageItems = productsList.subList(from, to);

        // featured sản phẩm đầu trang dựa trên danh sách sau lọc
        java.util.List<Product> featured = new java.util.ArrayList<>();
        for (int i = 0; i < pageItems.size() && i < 3; i++) {
            featured.add(pageItems.get(i));
        }
        request.setAttribute("featuredList", featured);

        response.setContentType("text/html;charset=UTF-8");
        request.setAttribute("page", page);
        request.setAttribute("total", total);
        request.setAttribute("numberPage", numberPage);
        request.setAttribute("productList", pageItems);
        request.getRequestDispatcher("/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
