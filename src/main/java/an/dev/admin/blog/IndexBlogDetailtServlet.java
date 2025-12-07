package an.dev.admin.blog;

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

public class IndexBlogDetailtServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogIdStr = request.getParameter("blogId");
        
        if (blogIdStr == null || blogIdStr.isEmpty()) {
            response.sendRedirect("IndexBlogServlet");
            return;
        }
        
        int blogId = Integer.parseInt(blogIdStr);
        
        BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
        Blog blog = blogDao.find(blogId);
        
        BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
        BlogDetailt blogDetailt = blogDetailtDao.findByBlogId(blogId);
        
        request.setAttribute("blog", blog);
        request.setAttribute("blogDetailt", blogDetailt);
        request.getRequestDispatcher("admin/blog/detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
