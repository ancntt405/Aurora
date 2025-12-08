package an.dev.admin.blogdetailt;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.model.BlogDetailt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

public class EditBlogDetailtServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
        BlogDetailt blogDetailt = blogDetailtDao.find(id);
        
        request.setAttribute("blogDetailt", blogDetailt);
        request.getRequestDispatcher("/admin/blogdetailt/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        int blogId = Integer.parseInt(request.getParameter("blog_id"));
        String content = request.getParameter("content");
        
        BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
        BlogDetailt blogDetailt = blogDetailtDao.find(id);
        
        if (blogDetailt != null) {
            blogDetailt.setContent(content);
            blogDetailt.setUpdated_at(new Timestamp(System.currentTimeMillis()));
            blogDetailtDao.update(blogDetailt);
        }
        
        response.sendRedirect("IndexBlogDetailtServlet");
    }
}
