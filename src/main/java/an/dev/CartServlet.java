package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.imp.CartImpl;
import an.dev.data.model.*;
import an.dev.util.Helper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class CartServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        List<OrderItems> cart = new ArrayList<>();
        List<CartItem> cartItems = new ArrayList<>();

        if (user != null && user.getId() > 0) {
            an.dev.data.imp.CartImpl cartDao = (an.dev.data.imp.CartImpl) DatabaseDao.getInstance().getCartDao();
            List<Cart> rows = cartDao.findAllByUser(user.getId());
            for (Cart row : rows) {
                OrderItems oi = new OrderItems(0, row.getQuantity(), 0, 0, row.getProduct_id());
                cart.add(oi);
                try {
                    Product product = DatabaseDao.getInstance().getProductDao().find(row.getProduct_id());
                    if (product != null) {
                        oi.setPrice(product.getPrice());
                        cartItems.add(new CartItem(oi, product));
                    }
                } catch (Exception ignored) { }
            }
        } else {
            List<OrderItems> sessionCart = (List<OrderItems>) session.getAttribute("cart");
            if (sessionCart != null) cart = sessionCart;
            for (OrderItems orderItem : cart) {
                try {
                    Product product = DatabaseDao.getInstance().getProductDao().find(orderItem.getProduct_id());
                    if (product != null) cartItems.add(new CartItem(orderItem, product));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();
        session.setAttribute("totalQuantity", totalQuantity);

        request.setAttribute("cart", cart);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("total", Helper.total(cart));
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("===== CART SERVLET - doPost CALLED =====");

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "create";
        }

        // Bắt buộc đăng nhập cho các thao tác giỏ hàng để lưu DB
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getId() <= 0) {
            // Ghi nhớ tham số để có thể thêm lại sau khi đăng nhập (tùy chọn)
            java.util.Map<String, String[]> pending = new java.util.HashMap<>(request.getParameterMap());
            session.setAttribute("pendingCartRequest", pending);
            session.setAttribute("message", "Vui lòng đăng nhập để thêm/ sửa giỏ hàng");
            response.sendRedirect("LoginServlet");
            return;
        }
        System.out.println("[CartServlet] doPost userId=" + user.getId() + ", action=" + action);

        switch (action) {
            case "create":
            case "add":
                createOrder(request);
                break;
            case "update":
                updateOrder(request);
                break;
            case "delete":
                deleteOrder(request);
                break;
            case "toCheckout":
                prepareCheckout(request);
                response.sendRedirect("cheackout.jsp");
                return;
            default:
                throw new AssertionError("Unknown action: " + action);
        }

        response.sendRedirect("CartServlet");
    }

    private void prepareCheckout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        List<OrderItems> cart = new ArrayList<>();
        List<CartItem> cartItems = new ArrayList<>();

        if (user != null && user.getId() > 0) {
            an.dev.data.imp.CartImpl cartDao = (an.dev.data.imp.CartImpl) DatabaseDao.getInstance().getCartDao();
            List<Cart> rows = cartDao.findAllByUser(user.getId());
            for (Cart row : rows) {
                OrderItems oi = new OrderItems(0, row.getQuantity(), 0, 0, row.getProduct_id());
                cart.add(oi);
                try {
                    Product product = DatabaseDao.getInstance().getProductDao().find(row.getProduct_id());
                    if (product != null) {
                        oi.setPrice(product.getPrice());
                        cartItems.add(new CartItem(oi, product));
                    }
                } catch (Exception ignored) { }
            }
        } else {
            List<OrderItems> sessionCart = (List<OrderItems>) session.getAttribute("cart");
            if (sessionCart != null) cart = sessionCart;
            for (OrderItems orderItem : cart) {
                try {
                    Product product = DatabaseDao.getInstance().getProductDao().find(orderItem.getProduct_id());
                    if (product != null) cartItems.add(new CartItem(orderItem, product));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();
        session.setAttribute("totalQuantity", totalQuantity);
        session.setAttribute("cartItems", cartItems);
        session.setAttribute("total", Helper.total(cart));
    }

    private void createOrder(HttpServletRequest request) {
        String quantityStr = request.getParameter("quantity");
        String productIdStr = request.getParameter("productId");
        String priceStr = request.getParameter("price");

        if (productIdStr == null) {
            System.out.println("ERROR: Missing productId!");
            return;
        }

        int quantity = 1;
        int productId;
        double price = 0;
        try { quantity = (quantityStr != null && !quantityStr.isBlank()) ? Integer.parseInt(quantityStr) : 1; }
        catch (NumberFormatException ignored) { quantity = 1; }
        try { productId = Integer.parseInt(productIdStr); }
        catch (NumberFormatException e) { System.out.println("ERROR: Invalid productId"); return; }
        if (priceStr != null && !priceStr.isBlank()) {
            try { price = Double.parseDouble(priceStr); } catch (NumberFormatException ignored) { price = 0; }
        }
        if (price <= 0) {
            try {
                an.dev.data.model.Product p = DatabaseDao.getInstance().getProductDao().find(productId);
                if (p != null) price = p.getPrice();
            } catch (Exception ignored) { }
        }
        if (price <= 0) {
            System.out.println("WARN: Price unresolved, defaulting to 0 - ignoring add");
            return;
        }
        System.out.println("[CartServlet] createOrder productId=" + productId + ", qty=" + quantity + ", price=" + price);

        OrderItems orderItem = new OrderItems(0, quantity, price, 0, productId);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && user.getId() > 0) {
            try {
                int userId = user.getId();
                CartImpl cartDao = (CartImpl) DatabaseDao.getInstance().getCartDao();
                Cart existingCart = cartDao.findByUserAndProduct(userId, productId);
                if (existingCart != null) {
                    cartDao.updateQuantity(userId, productId, existingCart.getQuantity() + quantity);
                } else {
                    Cart cartRow = new Cart();
                    cartRow.setUser_id(userId);
                    cartRow.setProduct_id(productId);
                    cartRow.setQuantity(quantity);
                    cartRow.setCreated_at(new Timestamp(System.currentTimeMillis()));
                    cartDao.insert(cartRow);
                }

                int totalQuantity = ((CartImpl) DatabaseDao.getInstance().getCartDao()).sumQuantityByUser(userId);
                session.setAttribute("totalQuantity", totalQuantity);
                System.out.println("[CartServlet] DB cart updated. totalQuantity=" + totalQuantity);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {

            List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
            boolean isExistInCart = false;
            if (cart == null) cart = new ArrayList<>();
            else {
                for (OrderItems ord : cart) {
                    if (ord.getProduct_id() == productId) { ord.setQuantity(ord.getQuantity() + quantity); isExistInCart = true; }
                }
            }
            if (!isExistInCart) cart.add(orderItem);
            session.setAttribute("cart", cart);
            int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();
            session.setAttribute("totalQuantity", totalQuantity);
        }
    }

    private void deleteOrder(HttpServletRequest request) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getId() > 0) {
            CartImpl cartDao = (CartImpl) DatabaseDao.getInstance().getCartDao();
            cartDao.deleteByUserAndProduct(user.getId(), productId);
            int totalQuantity = cartDao.sumQuantityByUser(user.getId());
            session.setAttribute("totalQuantity", totalQuantity);
        } else {
            List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
            if (cart != null) cart.removeIf(ord -> ord.getProduct_id() == productId);
            session.setAttribute("cart", cart);
            int totalQuantity = cart != null ? cart.stream().mapToInt(OrderItems::getQuantity).sum() : 0;
            session.setAttribute("totalQuantity", totalQuantity);
        }
    }

    private void updateOrder(HttpServletRequest request) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getId() > 0) {
            CartImpl cartDao = (CartImpl) DatabaseDao.getInstance().getCartDao();
            cartDao.updateQuantity(user.getId(), productId, quantity);
            int totalQuantity = cartDao.sumQuantityByUser(user.getId());
            session.setAttribute("totalQuantity", totalQuantity);
        } else {
            List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
            if (cart != null && !cart.isEmpty()) {
                for (OrderItems ord : cart) {
                    if (ord.getProduct_id() == productId) { ord.setQuantity(quantity); }
                }
            }
            session.setAttribute("cart", cart);
            int totalQuantity = cart != null ? cart.stream().mapToInt(OrderItems::getQuantity).sum() : 0;
            session.setAttribute("totalQuantity", totalQuantity);
        }
    }
}
