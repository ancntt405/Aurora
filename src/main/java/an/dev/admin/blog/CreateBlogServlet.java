package an.dev.admin.blog;

import an.dev.admin.BaseAdminServlet;
import an.dev.admin.products.UploadFileHelper;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.BlogDao;
import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.model.Blog;
import an.dev.data.model.BlogDetailt;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.Timestamp;

@MultipartConfig
public class CreateBlogServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/blog/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        
        // Upload image
        String imageUrl = "";
        try {
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                imageUrl = UploadFileHelper.uploadSingleFile("img", imagePart, request);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Insert blog
        BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
        Blog blog = new Blog(0, title, description, imageUrl);
        int blogId = blogDao.insert(blog);
        
        // Insert blog detail
        if (blogId > 0 && content != null && !content.isEmpty()) {
            BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
            Timestamp now = new Timestamp(System.currentTimeMillis());
            BlogDetailt blogDetailt = new BlogDetailt(0, blogId, content, now, now);
            blogDetailtDao.insert(blogDetailt);
        }
        
        response.sendRedirect("IndexBlogServlet");
    }
}
