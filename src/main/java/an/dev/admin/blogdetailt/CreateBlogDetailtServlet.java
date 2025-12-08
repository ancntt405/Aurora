package an.dev.admin.blogdetailt;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.BlogDao;
import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.model.Blog;
import an.dev.data.model.BlogDetailt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

public class CreateBlogDetailtServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
        List<Blog> blogList = blogDao.findAll();
        
        request.setAttribute("blogList", blogList);
        request.getRequestDispatcher("/admin/blogdetailt/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int blogId = Integer.parseInt(request.getParameter("blog_id"));
        String content = request.getParameter("content");

        BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
        BlogDetailt existing = blogDetailtDao.findByBlogId(blogId);
        
        if (existing != null) {
            request.setAttribute("error", "Blog này đã có nội dung chi tiết!");
            doGet(request, response);
            return;
        }

        Timestamp now = new Timestamp(System.currentTimeMillis());
        BlogDetailt blogDetailt = new BlogDetailt(0, blogId, content, now, now);
        blogDetailtDao.insert(blogDetailt);
        
        response.sendRedirect("IndexBlogDetailtServlet");
    }
}
