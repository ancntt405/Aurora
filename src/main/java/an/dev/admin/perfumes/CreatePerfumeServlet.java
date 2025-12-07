package an.dev.admin.perfumes;

import an.dev.admin.BaseAdminServlet;
import an.dev.admin.products.UploadFileHelper;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.CategoryDao;
import an.dev.data.dao.PerfumeDao;
import an.dev.data.model.Category;
import an.dev.data.model.Perfume;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@MultipartConfig
public class CreatePerfumeServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        List<Category> categoryList = categoryDao.findAll();
        
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("admin/perfume/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String priceOldStr = request.getParameter("price_old");
        String quantityStr = request.getParameter("quantity");
        String volumeStr = request.getParameter("volume");
        String scentType = request.getParameter("scent_type");
        String gender = request.getParameter("gender");
        String categoryIdStr = request.getParameter("category_id");
        
        String image = "";
        try {
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                image = UploadFileHelper.uploadSingleFile("img", imagePart, request);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        double price = Double.parseDouble(priceStr);
        double priceOld = priceOldStr != null && !priceOldStr.isEmpty() ? Double.parseDouble(priceOldStr) : 0;
        int quantity = Integer.parseInt(quantityStr);
        int volume = Integer.parseInt(volumeStr);
        int categoryId = Integer.parseInt(categoryIdStr);
        
        Perfume perfume = new Perfume(name, brand, image, description, price, priceOld, 
                                     quantity, volume, scentType, gender, 0, categoryId, 
                                     new Timestamp(System.currentTimeMillis()), true);
        
        PerfumeDao perfumeDao = DatabaseDao.getInstance().getPerfumeDao();
        perfumeDao.insert(perfume);
        
        response.sendRedirect("IndexPerfumeServlet");
    }
}
