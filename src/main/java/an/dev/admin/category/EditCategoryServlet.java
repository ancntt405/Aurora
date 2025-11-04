package an.dev.admin.category;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.CategoryDao;
import an.dev.data.model.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 10 * 1024 * 1024,     // 10MB
        maxRequestSize = 50 * 1024 * 1024   // 50MB
)
public class EditCategoryServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String idParam = request.getParameter("categoryId");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("IndexCategoryServlet");
            return;
        }
        try {
            int categoryId = Integer.parseInt(idParam);
            Category category = DatabaseDao.getInstance().getCategoryDao().find(categoryId);
            if (category == null) {
                response.sendRedirect("IndexCategoryServlet");
                return;
            }
            session.setAttribute("category", category);
            request.getRequestDispatcher("admin/category/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("IndexCategoryServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        HttpSession session = request.getSession();
        String idParam = request.getParameter("categoryId");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("IndexCategoryServlet");
            return;
        }
        try {
            int categoryId = Integer.parseInt(idParam);
            Category category = categoryDao.find(categoryId);
            if (category == null) {
                response.sendRedirect("IndexCategoryServlet");
                return;
            }
            // Lấy dữ liệu từ form
            String name = request.getParameter("name");
            boolean status = request.getParameter("status") != null;
            // Upload ảnh
            Part filePart = request.getPart("thumbnail"); // input name="thumbnail"
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Thư mục lưu ảnh (assets/images)
                String uploadPath = request.getServletContext().getRealPath("")
                        + File.separator + "assets" + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                // Lưu file mới
                filePart.write(uploadPath + File.separator + fileName);
                // Cập nhật DB với ảnh mới
                category.setThumbnail(fileName);
            }
            // Giữ ảnh cũ nếu không upload mới
            category.setName(name.trim());
            category.setStatus(status);

            categoryDao.update(category);
            response.sendRedirect("IndexCategoryServlet");

        } catch (NumberFormatException e) {
            response.sendRedirect("IndexCategoryServlet");
        }
    }
}
