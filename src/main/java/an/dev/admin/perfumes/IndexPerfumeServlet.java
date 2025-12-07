package an.dev.admin.perfumes;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.PerfumeDao;
import an.dev.data.model.Perfume;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexPerfumeServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PerfumeDao perfumeDao = DatabaseDao.getInstance().getPerfumeDao();
        List<Perfume> perfumeList = perfumeDao.findAll();
        
        request.setAttribute("perfumeList", perfumeList);
        request.getRequestDispatcher("admin/perfume/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
