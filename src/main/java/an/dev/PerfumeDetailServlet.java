package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.PerfumeDao;
import an.dev.data.model.Perfume;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class PerfumeDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String perfumeIdStr = request.getParameter("perfumeId");
        
        if (perfumeIdStr == null || perfumeIdStr.isEmpty()) {
            response.sendRedirect("PerfumeServlet");
            return;
        }
        
        int perfumeId = Integer.parseInt(perfumeIdStr);
        PerfumeDao perfumeDao = DatabaseDao.getInstance().getPerfumeDao();
        Perfume perfume = perfumeDao.find(perfumeId);
        
        if (perfume == null) {
            response.sendRedirect("PerfumeServlet");
            return;
        }
        
        // Tăng lượt xem
        perfume.setView(perfume.getView() + 1);
        perfumeDao.updateView(perfume);
        
        request.setAttribute("perfume", perfume);
        request.getRequestDispatcher("perfume-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
