package an.dev.admin.contact;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.ContactDao;
import an.dev.data.model.Contact;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ViewContactServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        ContactDao contactDao = DatabaseDao.getInstance().getContactDao();
        Contact contact = contactDao.find(id);
        if (contact != null && "new".equals(contact.getStatus())) {
            contact.setStatus("read");
            contactDao.update(contact);
        }
        
        request.setAttribute("contact", contact);
        request.getRequestDispatcher("/admin/contact/view.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
