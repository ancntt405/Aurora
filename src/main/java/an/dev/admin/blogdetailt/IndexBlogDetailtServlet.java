package an.dev.admin.blogdetailt;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.model.BlogDetailt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexBlogDetailtServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDetailtDao blogDetailtDao = DatabaseDao.getInstance().getBlogDetailtDao();
        List<BlogDetailt> blogDetailtList = blogDetailtDao.findAll();
        
        request.setAttribute("blogDetailtList", blogDetailtList);
        request.getRequestDispatcher("/admin/blogdetailt/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
