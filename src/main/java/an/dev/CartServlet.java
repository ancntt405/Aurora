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
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        List<CartItem> cartItems = new ArrayList<>();
        for (OrderItems orderItem : cart) {
            try {
                Product product = DatabaseDao.getInstance().getProductDao().find(orderItem.getProduct_id());
                if (product != null) {
                    CartItem cartItem = new CartItem(orderItem, product);
                    cartItems.add(cartItem);
                }
            } catch (Exception e) {
                System.out.println("Error getting product details for product ID: " + orderItem.getProduct_id());
                e.printStackTrace();
            }
        }

        int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();

        Logger.getLogger(CartServlet.class.getName()).log(Level.INFO, "Cart size: {0}", cart.size());

        request.setAttribute("cart", cart);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("total", Helper.total(cart));
        session.setAttribute("totalQuantity", totalQuantity);

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
            default:
                throw new AssertionError("Unknown action: " + action);
        }

        response.sendRedirect("CartServlet");
    }

    private void createOrder(HttpServletRequest request) {
        String quantityStr = request.getParameter("quantity");
        String productIdStr = request.getParameter("productId");
        String priceStr = request.getParameter("price");

        if (quantityStr == null || productIdStr == null || priceStr == null) {
            System.out.println("ERROR: Missing parameters!");
            return;
        }

        int quantity = Integer.parseInt(quantityStr);
        int productId = Integer.parseInt(productIdStr);
        double price = Double.parseDouble(priceStr);

        OrderItems orderItem = new OrderItems(0, quantity, price, 0, productId);

        HttpSession session = request.getSession();
        List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
        boolean isExistInCart = false;

        if (cart == null) {
            cart = new ArrayList<>();
        } else {
            for (OrderItems ord : cart) {
                if (ord.getProduct_id() == productId) {
                    ord.setQuantity(ord.getQuantity() + quantity);
                    isExistInCart = true;
                }
            }
        }

        if (!isExistInCart) {
            cart.add(orderItem);
        }

        // Lưu vào database nếu user đã đăng nhập
        try {
            User user = (User) session.getAttribute("user");
            if (user != null && user.getId() > 0) {
                int userId = user.getId();
                CartImpl cartDao = (CartImpl) DatabaseDao.getInstance().getCartDao();

                Cart existingCart = cartDao.findByUserAndProduct(userId, productId);
                if (existingCart != null) {
                    cartDao.updateQuantity(userId, productId, existingCart.getQuantity() + quantity);
                } else {
                    Cart cartItem = new Cart();
                    cartItem.setUser_id(userId);
                    cartItem.setProduct_id(productId);
                    cartItem.setQuantity(quantity);
                    cartItem.setCreated_at(new Timestamp(System.currentTimeMillis()));
                    cartDao.insert(cartItem);
                }
            } else {
                System.out.println("User not logged in or invalid user ID, cannot save to database");
            }
        } catch (Exception e) {
            System.out.println("Error saving cart to database: " + e.getMessage());
            e.printStackTrace();
        }

        session.setAttribute("cart", cart);
        int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();
        session.setAttribute("totalQuantity", totalQuantity);
    }

    private void deleteOrder(HttpServletRequest request) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
        if (cart != null) {
            cart.removeIf(ord -> ord.getProduct_id() == productId);
        }
        session.setAttribute("cart", cart);
        int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();
        session.setAttribute("totalQuantity", totalQuantity);
    }

    private void updateOrder(HttpServletRequest request) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            for (OrderItems ord : cart) {
                if (ord.getProduct_id() == productId) {
                    ord.setQuantity(quantity);
                }
            }
        }
        session.setAttribute("cart", cart);
        int totalQuantity = cart.stream().mapToInt(OrderItems::getQuantity).sum();
        session.setAttribute("totalQuantity", totalQuantity);
    }
}
