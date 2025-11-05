package an.dev.admin.banners;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.model.Banner;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB in memory before disk
        maxFileSize = 10L * 1024 * 1024,      // 10MB per file
        maxRequestSize = 20L * 1024 * 1024    // 20MB total
)
public class CreateBannerServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {

            String title = trimOrEmpty(request.getParameter("title"));
            String statusParam = request.getParameter("status");
            boolean status = "true".equalsIgnoreCase(statusParam) || "on".equalsIgnoreCase(statusParam);


            if (title.isEmpty()) {
                session.setAttribute("errorMessage", "Vui lòng nhập tiêu đề banner");
                request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
                return;
            }

            Part filePart = request.getPart("file"); // name="file" in create.jsp
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("errorMessage", "Vui lòng chọn ảnh banner");
                request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
                return;
            }

            String submittedName = getFileName(filePart);
            if (submittedName == null || submittedName.isBlank()) {
                session.setAttribute("errorMessage", "Tên file ảnh không hợp lệ");
                request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
                return;
            }

            String safeFileName = submittedName.replaceAll("[^a-zA-Z0-9._-]", "_");

            String imagesDirRealPath = request.getServletContext().getRealPath("/img");
            if (imagesDirRealPath == null) {
                session.setAttribute("errorMessage", "Không xác định được thư mục lưu ảnh trên server");
                request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
                return;
            }

            File imagesDir = new File(imagesDirRealPath);
            if (!imagesDir.exists() && !imagesDir.mkdirs()) {
                session.setAttribute("errorMessage", "Không thể tạo thư mục lưu ảnh");
                request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
                return;
            }

            Path target = imagesDir.toPath().resolve(safeFileName);
            if (Files.exists(target)) {
                String base = safeFileName;
                String name = base;
                String ext = "";
                int dot = base.lastIndexOf('.');
                if (dot > 0) { name = base.substring(0, dot); ext = base.substring(dot); }
                String unique = name + "_" + System.currentTimeMillis() + ext;
                target = imagesDir.toPath().resolve(unique);
                safeFileName = unique;
            }
            try {
                Files.copy(filePart.getInputStream(), target);
            } finally {
                filePart.delete();
            }
            Banner banner = new Banner(safeFileName, title, status);
            DatabaseDao.getInstance().getBannerDao().insert(banner);

            response.sendRedirect(request.getContextPath() + "/IndexBannerServlet");
        } catch (IllegalStateException ex) {
            session.setAttribute("errorMessage", "Ảnh tải lên vượt quá dung lượng cho phép");
            request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo banner: " + ex.getMessage());
            request.getRequestDispatcher("/admin/banner/create.jsp").forward(request, response);
        }
    }

    private static String trimOrEmpty(String s) {
        return s == null ? "" : s.trim();
    }

    private static String getFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String seg : cd.split(";")) {
            seg = seg.trim();
            if (seg.startsWith("filename")) {
                String name = seg.substring(seg.indexOf('=') + 1).trim().replace("\"", "");
           
                return name.substring(Math.max(name.lastIndexOf('/'), name.lastIndexOf('\\')) + 1);
            }
        }
        return null;
    }
}
