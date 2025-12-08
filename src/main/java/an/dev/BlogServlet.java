package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.BlogDao;
import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.model.Blog;
import an.dev.data.model.BlogDetailt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class BlogServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        
        String blogIdParam = request.getParameter("blogId");
        
        if (blogIdParam != null && !blogIdParam.isEmpty()) {
            // Hiển thị chi tiết blog
            try {
                int blogId = Integer.parseInt(blogIdParam);
                BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
                Blog blog = blogDao.find(blogId);
                
                if (blog != null) {
                    BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
                    BlogDetailt blogDetailt = blogDetailtDao.findByBlogId(blogId);
                    
                    request.setAttribute("blog", blog);
                    request.setAttribute("blogDetailt", blogDetailt);
                    request.getRequestDispatcher("/blog-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/BlogServlet");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/BlogServlet");
            }
        } else {
            // Hiển thị danh sách blog
            BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
            List<Blog> blogList = blogDao.findAll();
            request.setAttribute("blogList", blogList);
            request.getRequestDispatcher("/blog.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
