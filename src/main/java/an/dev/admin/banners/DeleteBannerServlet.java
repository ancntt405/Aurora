package an.dev.admin.banners;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteBannerServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bannerId = Integer.parseInt(request.getParameter("bannerId"));
        DatabaseDao.getInstance().getBannerDao().delete(bannerId);

        response.sendRedirect("IndexBannerServlet");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
