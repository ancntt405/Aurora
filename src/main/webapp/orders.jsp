<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đơn mua</title>
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
  <link href="css/style.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="./inc/header.jsp" />

  <div class="container py-5">
    <h3 class="mb-4"><i class="fas fa-list-ul me-2 text-primary"></i>Đơn mua của tôi</h3>

    <div class="table-responsive bg-white shadow-sm rounded">
      <table class="table align-middle mb-0">
        <thead>
          <tr class="text-center">
            <th class="text-start">Mã đơn</th>
            <th>Ngày tạo</th>
            <th>Trạng thái</th>
            <th>Chi tiết</th>
          </tr>
        </thead>
        <tbody>
        <c:choose>
          <c:when test="${empty myOrders}">
            <tr><td colspan="5" class="text-center py-4">Chưa có đơn hàng nào.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="o" items="${myOrders}">
              <tr class="text-center">
                <td class="text-start fw-semibold">${o.code}</td>
                <td><fmt:formatDate value="${o.created_at}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td>
                  <span class="badge ${o.status ? 'bg-success' : 'bg-warning text-dark'}">
                    ${o.status ? 'Đã xác nhận' : 'Đang xử lý'}
                  </span>
                </td>
                <td>
                  <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/OrderDetailServlet?code=${o.code}">
                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                  </a>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>
    </div>

    <div class="mt-3">
      <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-1"></i>Tiếp tục mua sắm</a>
    </div>
  </div>

  <%@include file='./inc/footer.jsp' %>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="js/main.js"></script>
</body>
</html>