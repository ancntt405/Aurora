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
import java.util.List;

@MultipartConfig
public class EditPerfumeServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int perfumeId = Integer.parseInt(request.getParameter("perfumeId"));
        
        PerfumeDao perfumeDao = DatabaseDao.getInstance().getPerfumeDao();
        Perfume perfume = perfumeDao.find(perfumeId);
        
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        List<Category> categoryList = categoryDao.findAll();
        
        request.setAttribute("perfume", perfume);
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("admin/perfume/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int perfumeId = Integer.parseInt(request.getParameter("perfumeId"));
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
        
        PerfumeDao perfumeDao = DatabaseDao.getInstance().getPerfumeDao();
        Perfume perfume = perfumeDao.find(perfumeId);
        
        String image = perfume.getImage();
        try {
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String newImage = UploadFileHelper.uploadSingleFile("img", imagePart, request);
                if (newImage != null && !newImage.isEmpty()) {
                    image = newImage;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        double price = Double.parseDouble(priceStr);
        double priceOld = priceOldStr != null && !priceOldStr.isEmpty() ? Double.parseDouble(priceOldStr) : 0;
        int quantity = Integer.parseInt(quantityStr);
        int volume = Integer.parseInt(volumeStr);
        int categoryId = Integer.parseInt(categoryIdStr);
        
        perfume.setName(name);
        perfume.setBrand(brand);
        perfume.setImage(image);
        perfume.setDescription(description);
        perfume.setPrice(price);
        perfume.setPrice_old(priceOld);
        perfume.setQuantity(quantity);
        perfume.setVolume(volume);
        perfume.setScent_type(scentType);
        perfume.setGender(gender);
        perfume.setCategory_id(categoryId);
        
        perfumeDao.update(perfume);
        
        response.sendRedirect("IndexPerfumeServlet");
    }
}
