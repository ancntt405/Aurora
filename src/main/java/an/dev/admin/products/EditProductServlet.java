package an.dev.admin.products;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.GalleryDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.model.Category;
import an.dev.data.model.Gallery;
import an.dev.data.model.Product;
import an.dev.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class EditProductServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String productIdRaw = request.getParameter("productId");
        if (productIdRaw == null || productIdRaw.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Thiếu mã sản phẩm (productId).");
            response.sendRedirect("IndexProductsServlet");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdRaw.trim());
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ.");
            response.sendRedirect("IndexProductsServlet");
            return;
        }

        Product product = DatabaseDao.getInstance().getProductDao().find(productId);
        if (product == null) {
            session.setAttribute("errorMessage", "Không tìm thấy sản phẩm.");
            response.sendRedirect("IndexProductsServlet");
            return;
        }

        List<Category> categoryList = DatabaseDao.getInstance().getCategoryDao().findAll();
        List<Gallery> galleries = DatabaseDao.getInstance().getGalleryDao().findByProductId(productId);

        request.setAttribute("product", product);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("galleries", galleries);

        System.out.println("EditProductServlet - Product ID: " + productId);
        System.out.println("EditProductServlet - Product: " + product.getName());
        System.out.println("EditProductServlet - Categories: " + categoryList.size());
        System.out.println("EditProductServlet - Galleries: " + (galleries != null ? galleries.size() : 0));

        // Forward bằng đường dẫn tuyệt đối từ context root
        request.getRequestDispatcher("/admin/products/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductDao productsDao = DatabaseDao.getInstance().getProductDao();

        String productIdRaw = request.getParameter("productId");
        if (productIdRaw == null || productIdRaw.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Thiếu mã sản phẩm (productId).");
            response.sendRedirect("IndexProductsServlet");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdRaw.trim());
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ.");
            response.sendRedirect("IndexProductsServlet");
            return;
        }

        Product product = productsDao.find(productId);
        if (product == null) {
            session.setAttribute("errorMessage", "Không tìm thấy sản phẩm.");
            response.sendRedirect("IndexProductsServlet");
            return;
        }

        String image = request.getParameter("image"); // main image URL (optional)
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin tên và mô tả!");
            request.setAttribute("product", product);
            request.setAttribute("categoryList", DatabaseDao.getInstance().getCategoryDao().findAll());
            request.getRequestDispatcher("/admin/products/edit.jsp").forward(request, response);
            return;
        }

        double price = parseDoubleOrDefault(request.getParameter("price"), product.getPrice());
        double priceOld = parseDoubleOrDefault(request.getParameter("price_old"), product.getPrice_old());
        int quantity = parseIntOrDefault(request.getParameter("quantity"), product.getQuantity());
        int view = parseIntOrDefault(request.getParameter("view"), product.getView());
        int categoryId = parseIntOrDefault(request.getParameter("categoryId"), product.getCategory_id());
        boolean status = parseBooleanOrDefault(request.getParameter("status"), product.getStatus());

        if (image != null && !image.trim().isEmpty()) {
            String v = image.trim();
            if (v.startsWith("img/")) v = v.substring(4);
            if (v.startsWith("assets/images/")) v = v.substring("assets/images/".length());
            int slash = Math.max(v.lastIndexOf('/'), v.lastIndexOf('\\'));
            if (slash >= 0 && slash + 1 < v.length()) v = v.substring(slash + 1);
            product.setImage(v);
        }
        product.setName(name.trim());
        product.setDescription(description.trim());
        product.setPrice(price);
        product.setPrice_old(priceOld);
        product.setQuantity(quantity);
        product.setView(view);
        product.setCategory_id(categoryId);
        product.setStatus(status);

        productsDao.update(product);
        updateGallery(product.getId(), request);
        response.sendRedirect("IndexProductsServlet");
    }

    private void updateGallery(int productId, HttpServletRequest request) {
        GalleryDao galleryDao = DatabaseDao.getInstance().getGalleryDao();
        List<String> photos = UploadFileHelper.uploadFile(Constants.UPLOAD_DIR, request);
        if (photos == null || photos.isEmpty()) {
            return;
        }
        galleryDao.deleteByProduct(productId);
        for (String photo : photos) {
            Gallery g = new Gallery(Constants.UPLOAD_DIR + "/" + photo, productId);
            galleryDao.insert(g);
        }
    }

    // Helpers
    private int parseIntOrDefault(String raw, int defaultVal) {
        if (raw == null || raw.trim().isEmpty()) return defaultVal;
        try {
            return Integer.parseInt(raw.trim());
        } catch (NumberFormatException e) {
            return defaultVal;
        }
    }

    private double parseDoubleOrDefault(String raw, double defaultVal) {
        if (raw == null || raw.trim().isEmpty()) return defaultVal;
        try {
            return Double.parseDouble(raw.trim());
        } catch (NumberFormatException e) {
            return defaultVal;
        }
    }

    private boolean parseBooleanOrDefault(String raw, boolean defaultVal) {
        if (raw == null) return defaultVal;
        // checkbox only sends when checked; value="true" in JSP
        return Boolean.parseBoolean(raw);
    }
}
