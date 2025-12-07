package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.dao.WishlistDao;
import an.dev.data.model.Product;
import an.dev.data.model.User;
import an.dev.data.model.Wishlist;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class WishlistServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }
        
        WishlistDao wishlistDao = DatabaseDao.getInstance().getWishlistDao();
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        
        List<Wishlist> wishlistItems = wishlistDao.findByUserId(user.getId());
        
        // Load product details for each wishlist item
        for (Wishlist item : wishlistItems) {
            Product product = productDao.find(item.getProduct_id());
            item.setProduct(product);
        }
        
        request.setAttribute("wishlistItems", wishlistItems);
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            return;
        }
        
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Thiếu thông tin sản phẩm\"}");
            return;
        }
        
        int productId = Integer.parseInt(productIdStr);
        WishlistDao wishlistDao = DatabaseDao.getInstance().getWishlistDao();
        
        if ("add".equals(action)) {
            // Check if already exists
            if (wishlistDao.exists(user.getId(), productId)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Sản phẩm đã có trong danh sách yêu thích\"}");
                return;
            }
            
            Wishlist wishlist = new Wishlist(user.getId(), productId);
            boolean success = wishlistDao.insert(wishlist);
            
            if (success) {
                int count = wishlistDao.countByUserId(user.getId());
                session.setAttribute("wishlistCount", count);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Đã thêm vào danh sách yêu thích\", \"count\": " + count + "}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể thêm vào danh sách yêu thích\"}");
            }
        } else if ("remove".equals(action)) {
            boolean success = wishlistDao.delete(user.getId(), productId);
            
            if (success) {
                int count = wishlistDao.countByUserId(user.getId());
                session.setAttribute("wishlistCount", count);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Đã xóa khỏi danh sách yêu thích\", \"count\": " + count + "}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xóa khỏi danh sách yêu thích\"}");
            }
        } else {
            response.sendRedirect("WishlistServlet");
        }
    }
}
