package an.dev;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

public class SearchServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        setDataAttributes(request);
        String keyword = request.getParameter("q");
        if (keyword == null || keyword.isEmpty()) keyword = request.getParameter("keyword");
        String categoryIdParam = request.getParameter("categoryId");
        String pageParam = request.getParameter("page");

        StringBuilder url = new StringBuilder(request.getContextPath()).append("/ShopServlet");
        boolean first = true;
        if (keyword != null && !keyword.trim().isEmpty()) {
            url.append(first ? "?" : "&").append("q=").append(URLEncoder.encode(keyword, "UTF-8"));
            first = false;
        }
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            url.append(first ? "?" : "&").append("categoryId=").append(categoryIdParam);
            first = false;
        }
        if (pageParam != null && !pageParam.isEmpty()) {
            url.append(first ? "?" : "&").append("page=").append(pageParam);
        }
        response.sendRedirect(url.toString());
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        doGet(request, response);
    }
}
