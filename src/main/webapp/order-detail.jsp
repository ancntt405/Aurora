<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi tiết đơn hàng</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
  <link href="css/style.css" rel="stylesheet">
  <style>
    .order-card{border:1px solid #eee;border-radius:12px}
    .perfume-thumb{width:64px;height:64px;object-fit:cover;border-radius:8px}
  </style>
</head>
<body>
  <jsp:include page="./inc/header.jsp" />

  <div class="container py-5">
    <div class="row justify-content-center mb-4">
      <div class="col-lg-10">
        <h3 class="mb-3"><i class="fas fa-file-invoice me-2 text-primary"></i>Chi tiết đơn hàng</h3>
        <div class="alert alert-light border d-flex justify-content-between align-items-center" role="alert">
          <div>
            <div class="fw-semibold">Mã đơn: <span class="text-primary">${order.code}</span></div>
            <small class="text-muted">Trạng thái: <span class="fw-semibold">${order.status ? 'Đã xác nhận' : 'Đang xử lý'}</span></small>
          </div>
          <div>
            <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/OrdersServlet"><i class="fas fa-arrow-left me-1"></i>Đơn mua</a>
          </div>
        </div>
      </div>
    </div>

    <div class="row justify-content-center">
      <div class="col-lg-10">
        <div class="p-4 order-card bg-white shadow-sm">
          <h5 class="mb-3"><i class="fas fa-shopping-bag me-2 text-primary"></i>Sản phẩm</h5>
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
              <c:choose>
                <c:when test="${empty cartItems}">
                  <tr><td colspan="5" class="text-center py-4">Không có sản phẩm.</td></tr>
                </c:when>
                <c:otherwise>
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
                </c:otherwise>
              </c:choose>
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
        </div>
      </div>
    </div>
  </div>

  <%@include file='./inc/footer.jsp' %>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="js/main.js"></script>
</body>
</html>