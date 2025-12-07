package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.CategoryDao;
import an.dev.data.dao.PerfumeDao;
import an.dev.data.model.Category;
import an.dev.data.model.Perfume;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class PerfumeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PerfumeDao perfumeDao = DatabaseDao.getInstance().getPerfumeDao();
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        
        String categoryIdStr = request.getParameter("categoryId");
        String brand = request.getParameter("brand");
        String gender = request.getParameter("gender");
        
        List<Perfume> perfumeList;
        
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            // Lọc theo category (nếu cần)
            perfumeList = perfumeDao.findAll();
        } else if (brand != null && !brand.isEmpty()) {
            perfumeList = perfumeDao.findByBrand(brand);
        } else if (gender != null && !gender.isEmpty()) {
            perfumeList = perfumeDao.findByGender(gender);
        } else {
            perfumeList = perfumeDao.findAll();
        }
        
        List<Category> categoryList = categoryDao.findAll();
        
        request.setAttribute("perfumeList", perfumeList);
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("perfume.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
