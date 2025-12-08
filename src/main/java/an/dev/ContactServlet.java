package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.ContactDao;
import an.dev.data.model.Contact;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

public class ContactServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            setDataAttributes(request);
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }

        Contact contact = new Contact();
        contact.setName(name);
        contact.setEmail(email);
        contact.setPhone(phone);
        contact.setSubject(subject);
        contact.setMessage(message);
        contact.setStatus("new");
        contact.setCreated_at(new Timestamp(System.currentTimeMillis()));
        contact.setUpdated_at(new Timestamp(System.currentTimeMillis()));

        ContactDao contactDao = DatabaseDao.getInstance().getContactDao();
        int id = contactDao.insert(contact);
        
        if (id > 0) {
            request.setAttribute("success", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi sớm nhất.");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
        }
        
        setDataAttributes(request);
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}
