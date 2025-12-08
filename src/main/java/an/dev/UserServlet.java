package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.Timestamp;

@MultipartConfig
public class UserServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }
        
        // lấy giá trị form data
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // cập nhật thông tin người dùng
        user.setName(name);
        user.setPhone(phone);
        user.setAddress(address);
        user.setUpdated_at(new Timestamp(System.currentTimeMillis()));
        
        // cập nhật trong database
        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        boolean updated = userDao.update(user);
        
        if (updated) {
            // cập nhật session
            session.setAttribute("user", user);
            request.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("error", "Cập nhật thông tin thất bại!");
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }
}
