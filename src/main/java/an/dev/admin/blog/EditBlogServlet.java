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
public class EditBlogServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        
        BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
        Blog blog = blogDao.find(blogId);
        
        BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
        BlogDetailt blogDetailt = blogDetailtDao.findByBlogId(blogId);
        
        request.setAttribute("blog", blog);
        request.setAttribute("blogDetailt", blogDetailt);
        request.getRequestDispatcher("admin/blog/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        
        BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
        Blog blog = blogDao.find(blogId);
        
        String imageUrl = blog.getImage_url();
        try {
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String newImage = UploadFileHelper.uploadSingleFile("img", imagePart, request);
                if (newImage != null && !newImage.isEmpty()) {
                    imageUrl = newImage;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        blog.setTitle(title);
        blog.setDescription(description);
        blog.setImage_url(imageUrl);
        blogDao.update(blog);
    
        if (content != null && !content.isEmpty()) {
            BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
            BlogDetailt blogDetailt = blogDetailtDao.findByBlogId(blogId);
            
            if (blogDetailt != null) {
                blogDetailt.setContent(content);
                blogDetailt.setUpdated_at(new Timestamp(System.currentTimeMillis()));
                blogDetailtDao.update(blogDetailt);
            } else {
                Timestamp now = new Timestamp(System.currentTimeMillis());
                BlogDetailt newDetail = new BlogDetailt(0, blogId, content, now, now);
                blogDetailtDao.insert(newDetail);
            }
        }
        
        response.sendRedirect("IndexBlogServlet");
    }
}
