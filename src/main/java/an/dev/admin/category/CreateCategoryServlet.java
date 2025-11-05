package an.dev.admin.category;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.model.Category;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class CreateCategoryServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        request.getRequestDispatcher("/admin/category/create.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Check if request is multipart
            if (!ServletFileUpload.isMultipartContent(request)) {
                session.setAttribute("errorMessage", "Form không hợp lệ");
                response.sendRedirect("CreateCategoryServlet");
                return;
            }

            // Create file upload handler
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            // Parse request
            List<FileItem> items = upload.parseRequest(request);

            String name = "";
            String thumbnail = "";
            boolean status = false;
            String uploadedFileName = "";

            // Process form fields
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");

                    switch (fieldName) {
                        case "name":
                            name = fieldValue;
                            break;
                        case "status":
                            status = "true".equals(fieldValue);
                            break;
                    }
                } else {
                    // hàm upload file ảnh 
                    if ("thumbnail".equals(item.getFieldName()) && !item.getName().isEmpty()) {
                        // tạo thư mục lưu trữ ảnh  (use /img/categories)
                        String uploadPath = getServletContext().getRealPath("/img/categories/");
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        // tạo ảnh
                        String originalFileName = item.getName();
                        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                        // lưu file ảnh 
                        File uploadedFile = new File(uploadDir, uniqueFileName);
                        item.write(uploadedFile);

                        thumbnail = "categories/" + uniqueFileName; 
                        uploadedFileName = uniqueFileName;
                    }
                }
            }

            if (name.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng nhập tên danh mục");
                response.sendRedirect("CreateCategoryServlet");
                return;
            }

            if (thumbnail.isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng chọn hình ảnh cho danh mục");
                response.sendRedirect("CreateCategoryServlet");
                return;
            }

            // Create and save category
            Category category = new Category(name, thumbnail, status);
            boolean success = DatabaseDao.getInstance().getCategoryDao().insert(category);

            if (success) {
                session.setAttribute("successMessage", "Tạo danh mục thành công!");
                response.sendRedirect("IndexCategoryServlet");
            } else {
                // Delete uploaded file if database insert failed
                if (!uploadedFileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("/img/categories/");
                    File fileToDelete = new File(uploadPath + uploadedFileName);
                    if (fileToDelete.exists()) {
                        fileToDelete.delete();
                    }
                }
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo danh mục. Vui lòng thử lại.");
                response.sendRedirect("CreateCategoryServlet");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("CreateCategoryServlet");
        }
    }
}
