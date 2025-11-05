package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            response.sendRedirect("HomeServlet");
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Kiểm tra email và password có được nhập không
        if (email == null || email.trim().isEmpty()) {
            session.setAttribute("errors", "Vui lòng nhập email!");
            response.sendRedirect("LoginServlet");
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            session.setAttribute("errors", "Vui lòng nhập mật khẩu!");
            response.sendRedirect("LoginServlet");
            return;
        }

        try {
            System.out.println("Email đăng nhập: " + email);

            UserDao userDao = DatabaseDao.getInstance().getUserDao();
            System.out.println("Đã lấy UserDao thành công");

            //tìm user chỉ bằng email trước
            System.out.println("Đang tìm user với email: " + email);
            User userByEmail = userDao.findByEmail(email);
            System.out.println("Kết quả tìm kiếm: " + (userByEmail != null ? "Tìm thấy" : "Không tìm thấy"));

            if (userByEmail == null) {
                System.out.println("Email không tồn tại trong hệ thống!");
                session.setAttribute("errors", "Email không tồn tại trong hệ thống!");
                response.sendRedirect("LoginServlet");
                return;
            }

            // Sau đó kiểm tra với cả email và password
            User user = userDao.find(email, password);

            if (user == null) {
                session.setAttribute("errors", "Mật khẩu không chính xác!");
                response.sendRedirect("LoginServlet");
            } else {
                // Đảm bảo user trong session có id hợp lệ (>0)
                if (user.getId() <= 0) {
                    User fixed = userDao.findByEmail(email);
                    if (fixed != null) {
                        user = fixed;
                    }
                }
                session.setAttribute("user", user);
                session.setAttribute("success", "Đăng nhập thành công!");
                System.out.println("[Login] userId=" + user.getId());

                // Nếu có yêu cầu thêm giỏ trước khi đăng nhập thì xử lý ngay sau đăng nhập
                Object pendingObj = session.getAttribute("pendingCartRequest");
                if (pendingObj instanceof java.util.Map) {
                    try {
                        @SuppressWarnings("unchecked")
                        java.util.Map<String, String[]> pending = (java.util.Map<String, String[]>) pendingObj;
                        String action = getFirst(pending.get("action"));
                        String productIdStr = getFirst(pending.get("productId"));
                        String qtyStr = getFirst(pending.get("quantity"));
                        if (action == null || action.isBlank()) action = "add";
                        if ("add".equalsIgnoreCase(action) || "create".equalsIgnoreCase(action)) {
                            int productId = Integer.parseInt(productIdStr);
                            int quantity = 1;
                            try { if (qtyStr != null && !qtyStr.isBlank()) quantity = Integer.parseInt(qtyStr); } catch (NumberFormatException ignore) {}

                            an.dev.data.imp.CartImpl cartDao = (an.dev.data.imp.CartImpl) DatabaseDao.getInstance().getCartDao();
                            an.dev.data.model.Cart existing = cartDao.findByUserAndProduct(user.getId(), productId);
                            if (existing != null) {
                                cartDao.updateQuantity(user.getId(), productId, existing.getQuantity() + quantity);
                            } else {
                                an.dev.data.model.Cart row = new an.dev.data.model.Cart();
                                row.setUser_id(user.getId());
                                row.setProduct_id(productId);
                                row.setQuantity(quantity);
                                row.setCreated_at(new java.sql.Timestamp(System.currentTimeMillis()));
                                cartDao.insert(row);
                            }
                            // Cập nhật badge tổng số lượng
                            int totalQuantity = ((an.dev.data.imp.CartImpl) DatabaseDao.getInstance().getCartDao()).sumQuantityByUser(user.getId());
                            session.setAttribute("totalQuantity", totalQuantity);
                        }
                    } catch (Exception ex) {
                        // ghi log nhưng vẫn tiếp tục điều hướng
                        ex.printStackTrace();
                    } finally {
                        session.removeAttribute("pendingCartRequest");
                    }
                    // Sau khi xử lý yêu cầu treo, chuyển về trang chủ
                    response.sendRedirect("HomeServlet");
                    return;
                }

                // Bỏ cơ chế redirectAfterLogin: luôn đưa về HomeServlet cho user thường
                session.removeAttribute("redirectAfterLogin");

                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("DashboardServlet");
                } else {
                    response.sendRedirect("HomeServlet");
                }
            }
        } catch (Exception e) {
            session.setAttribute("errors", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("LoginServlet");
        }
    }

    private static String getFirst(String[] arr) {
        return (arr != null && arr.length > 0) ? arr[0] : null;
    }

}
