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
import java.nio.file.Path;

@MultipartConfig(
        fileSizeThreshold = 1 * 1024 * 1024,  // 1MB
        maxFileSize = 10L * 1024 * 1024,      // 10MB
        maxRequestSize = 20L * 1024 * 1024    // 20MB
)
public class EditBannerServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        try {
            int bannerId = Integer.parseInt(request.getParameter("bannerId"));
            Banner banner = DatabaseDao.getInstance().getBannerDao().find(bannerId);
            if (banner == null) {
                session.setAttribute("errorMessage", "Banner không tồn tại");
                response.sendRedirect(request.getContextPath() + "/IndexBannerServlet");
                return;
            }
            // Dùng request scope cho JSP
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("/admin/banner/edit.jsp").forward(request, response);
        } catch (Exception ex) {
            session.setAttribute("errorMessage", "Không đọc được banner: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/IndexBannerServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        try {
            int bannerId = Integer.parseInt(request.getParameter("bannerId"));
            Banner banner = DatabaseDao.getInstance().getBannerDao().find(bannerId);
            if (banner == null) {
                session.setAttribute("errorMessage", "Banner không tồn tại");
                response.sendRedirect(request.getContextPath() + "/IndexBannerServlet");
                return;
            }

            String title = trimOrEmpty(request.getParameter("title"));
            String statusParam = request.getParameter("status");
            boolean status = "true".equalsIgnoreCase(statusParam) || "on".equalsIgnoreCase(statusParam);

            if (title.isEmpty()) {
                request.setAttribute("banner", banner);
                session.setAttribute("errorMessage", "Vui lòng nhập tiêu đề");
                request.getRequestDispatcher("/admin/banner/edit.jsp").forward(request, response);
                return;
            }

            // Xử lý ảnh mới (tùy chọn)
            Part filePart = request.getPart("file"); // name="file" trong form
            String newFileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                String submittedName = getFileName(filePart);
                if (submittedName != null && !submittedName.isBlank()) {
                    String safeFileName = submittedName.replaceAll("[^a-zA-Z0-9._-]", "_");

                    String imagesDirRealPath = request.getServletContext().getRealPath("/img");
                    File imagesDir = new File(imagesDirRealPath);
                    if (!imagesDir.exists()) imagesDir.mkdirs();

                    Path target = imagesDir.toPath().resolve(safeFileName);
                    if (java.nio.file.Files.exists(target)) {
                        String base = safeFileName;
                        String name = base;
                        String ext = "";
                        int dot = base.lastIndexOf('.');
                        if (dot > 0) { name = base.substring(0, dot); ext = base.substring(dot); }
                        String unique = name + "_" + System.currentTimeMillis() + ext;
                        target = imagesDir.toPath().resolve(unique);
                        safeFileName = unique;
                    }
                    java.nio.file.Files.copy(filePart.getInputStream(), target);
                    filePart.delete();

                    newFileName = safeFileName;
                }
            }

            // Cập nhật field
            banner.setTitle(title);
            banner.setStatus(status);
            if (newFileName != null) {
                banner.setImage(newFileName);
                // Optional: xóa ảnh cũ nếu cần
                // try { Files.deleteIfExists(Path.of(request.getServletContext().getRealPath("/assets/images/" + oldImage))); } catch (Exception ignored) {}
            }

            // Gọi DAO update (điều chỉnh tên hàm theo DAO thực tế)
            DatabaseDao.getInstance().getBannerDao().update(banner);

            response.sendRedirect(request.getContextPath() + "/IndexBannerServlet");
        } catch (IllegalStateException ex) {
            session.setAttribute("errorMessage", "Ảnh tải lên vượt quá dung lượng cho phép");
            // Pass lại banner để hiển thị
            int bannerId = Integer.parseInt(request.getParameter("bannerId"));
            Banner banner = DatabaseDao.getInstance().getBannerDao().find(bannerId);
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("/admin/banner/edit.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi khi cập nhật banner: " + ex.getMessage());
            int bannerId = Integer.parseInt(request.getParameter("bannerId"));
            Banner banner = DatabaseDao.getInstance().getBannerDao().find(bannerId);
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("/admin/banner/edit.jsp").forward(request, response);
        }
    }

    private static String trimOrEmpty(String s) { return s == null ? "" : s.trim(); }

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
