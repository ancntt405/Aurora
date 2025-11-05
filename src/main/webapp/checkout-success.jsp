<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="css/style.css" rel="stylesheet">
    <style>
      .order-card{border:1px solid #eee;border-radius:12px}
      .perfume-thumb{width:72px;height:72px;object-fit:cover;border-radius:8px}
    </style>
    </head>
<body>
    <jsp:include page="./inc/header.jsp" />

    <div class="container py-5">
      <div class="row justify-content-center mb-4">
        <div class="col-lg-10">
          <div class="alert alert-success shadow-sm" role="alert">
            <h4 class="alert-heading mb-2"><i class="fas fa-check-circle me-2"></i>Thanh toán thành công!</h4>
            <p class="mb-1"><i class="fas fa-receipt me-2"></i>Cảm ơn bạn đã tin tưởng AURORA. Mã đơn hàng của bạn: <strong>${order.code}</strong></p>
            <small class="text-muted">Chúng tôi sẽ sớm liên hệ để xác nhận và giao hàng.</small>
          </div>
        </div>
      </div>

      <div class="row justify-content-center">
        <div class="col-lg-10">
          <div class="p-4 order-card bg-white shadow-sm">
            <h5 class="mb-3"><i class="fas fa-shopping-bag me-2 text-primary"></i>Sản phẩm đã đặt</h5>
            <div class="table-responsive">
              <table class="table align-middle">
                <thead>
                  <tr class="text-center">
                    <th class="text-start">Sản phẩm</th>
                    <th>Mã</th>
                    <th>Đơn giá</th>
                    <th>SL</th>
                    <th>Thành tiền</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="ci" items="${cartItems}">
                    <tr class="text-center">
                      <td class="text-start d-flex align-items-center gap-3">
                        <img class="perfume-thumb" src="${pageContext.request.contextPath}/img/${ci.product.image}"
                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/img/product-1.png'" alt="${ci.product.name}">
                        <div>
                          <div class="fw-semibold">${ci.product.name}</div>
                          <small class="text-muted">Eau de parfum</small>
                        </div>
                      </td>
                      <td>#${ci.product.id}</td>
                      <td><fmt:formatNumber value="${ci.orderItem.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                      <td>${ci.orderItem.quantity}</td>
                      <td class="fw-semibold text-primary">
                        <fmt:formatNumber value="${ci.orderItem.quantity * ci.orderItem.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="4" class="text-end fw-semibold"><i class="fas fa-coins me-2 text-warning"></i>Tổng cộng</td>
                    <td class="text-primary fw-bold">
                      <fmt:formatNumber value="${total * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>

            <div class="d-flex gap-2 justify-content-end">
              <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/HomeServlet"><i class="fas fa-arrow-left me-1"></i>Tiếp tục mua sắm</a>
              <a class="btn btn-primary" href="${pageContext.request.contextPath}/OrdersServlet"><i class="fas fa-list-ul me-1"></i>Xem đơn mua</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%@include file='./inc/footer.jsp' %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
