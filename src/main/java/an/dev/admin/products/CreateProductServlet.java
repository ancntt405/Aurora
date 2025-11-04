package an.dev.admin.products;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.model.Category;
import an.dev.data.model.Gallery;
import an.dev.data.model.Product;
import an.dev.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;



@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
        maxFileSize = 1024 * 1024 * 50,       // 50 MB
        maxRequestSize = 1024 * 1024 * 100    // 100 MB
)
public class CreateProductServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categoryList = DatabaseDao.getInstance().getCategoryDao().findAll();
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("admin/products/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String name = defaultString(request.getParameter("name"));
        String description = defaultString(request.getParameter("description"));

        double price = Double.parseDouble(request.getParameter("price"));
        double price_old = Double.parseDouble(request.getParameter("price_old"));
        int quantity = parseIntOrDefault(request.getParameter("quantity"), 0);
        int view = parseIntOrDefault(request.getParameter("view"), 0);
        int category_id = parseIntOrDefault(request.getParameter("category_id"), 0);
        String createdAtParam = request.getParameter("created_at");
        Timestamp created_at = (createdAtParam != null)
                ? parseTimestampOrNow(createdAtParam)
                : new Timestamp(System.currentTimeMillis());
        boolean status = parseBooleanOrDefault(request.getParameter("status"), true);

        String image = "";
        try {
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                image = UploadFileHelper.uploadSingleFile(Constants.UPLOAD_DIR, imagePart, request); // trả về filename
            } else {
                image = defaultString(request.getParameter("image"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Saved product image filename = " + image);
        if (name.isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng nhập tên sản phẩm");
            request.getRequestDispatcher("admin/products/create.jsp").forward(request, response);
            return;
        }
        Category cat = DatabaseDao.getInstance().getCategoryDao().find(category_id);
        if (cat == null) {
            session.setAttribute("errorMessage", "Danh mục không tồn tại. Vui lòng chọn lại.");
            request.getRequestDispatcher("admin/products/create.jsp").forward(request, response);
            return;
        }

        Product products = new Product(name, image, description, price, price_old, quantity, view, category_id, created_at, status);

        int productId = DatabaseDao.getInstance().getProductDao().insert(products);
        if (productId <= 0) {
            session.setAttribute("errorMessage", "Không lưu được sản phẩm. Vui lòng thử lại.");
            request.getRequestDispatcher("admin/products/create.jsp").forward(request, response);
            return;
        }
        createGallery(productId, request);

        response.sendRedirect("IndexProductsServlet");
    }

    private void createGallery(int productId, HttpServletRequest request) {
        List<String> photos = UploadFileHelper.uploadFilesByField(Constants.UPLOAD_DIR, request, "photos");
        if (photos == null || photos.isEmpty()) return;

        for (String photo : photos) {
            Gallery g = new Gallery(Constants.UPLOAD_DIR + "/" + photo, productId);
            DatabaseDao.getInstance().getGalleryDao().insert(g);
        }
    }

    private String defaultString(String s) {
        return s == null ? "" : s.trim();
    }

    private int parseIntOrDefault(String s, int def) {
        try {
            return Integer.parseInt(defaultString(s));
        } catch (Exception e) {
            return def;
        }
    }

    private double parseDoubleOrDefault(String s, double def) {
        try {
            return Double.parseDouble(defaultString(s));
        } catch (Exception e) {
            return def;
        }
    }

    private boolean parseBooleanOrDefault(String s, boolean def) {
        String v = defaultString(s);
        if (v.isEmpty()) return def;
        return Boolean.parseBoolean(v);
    }

    private Timestamp parseTimestampOrNow(String s) {
        try {
            String v = defaultString(s);
            if (v.isEmpty()) return new Timestamp(System.currentTimeMillis());
            return Timestamp.valueOf(v);
        } catch (Exception e) {
            return new Timestamp(System.currentTimeMillis());
        }
    }
}
