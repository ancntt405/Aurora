package an.dev.admin.banners;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.model.Banner;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexBannerServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Banner> bannerList = DatabaseDao.getInstance().getBannerDao().findAll();
        request.setAttribute("bannerList", bannerList);
        request.getRequestDispatcher("admin/banner/index.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
