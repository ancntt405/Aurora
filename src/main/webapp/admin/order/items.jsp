<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
                                <title>Order Items</title>
                                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                                <meta content="" name="keywords">
                                <meta content="" name="description">
<link href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" rel="icon">

                                       <!-- Google Web Fonts -->
                                       <link rel="preconnect" href="https://fonts.googleapis.com">
                                       <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

                                       <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

                                       <!-- Icon Font Stylesheet -->
                                       <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
                                       <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

                                       <!-- Libraries Stylesheet -->
                                       <link href="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
                                       <link href="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

                                       <!-- Customized Bootstrap Stylesheet -->
                                       <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">

                                       <!-- Template Stylesheet -->
                                       <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">

                                       <!-- Admin CSS Fix -->
                                       <link href="${pageContext.request.contextPath}/assets/admin/css/admin-fix.css" rel="stylesheet">

  <style>
    #content-wrapper { margin-left: 250px; padding: 20px; }
    @media (max-width: 991.98px) { #content-wrapper { margin-left: 0; } }
    img.thumb { width: 64px; height: 64px; object-fit: cover; border-radius: 4px; }
  </style>
</head>
<body id="page-top">
<div id="wrapper">
  <%@include file="../inc/sidebar.jsp" %>
  <div id="content-wrapper" class="d-flex flex-column">
    <%@include file="../inc/navbar.jsp" %>

    <div class="container-fluid">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">Order #${order.id} - Code: ${order.code}</h4>
        <a href="IndexOrderServlet" class="btn btn-outline-secondary">Back</a>
      </div>

      <div class="card">
        <div class="card-header">
          <strong>Items</strong>
        </div>
        <div class="card-body">
          <c:choose>
            <c:when test="${empty items}">
              <div class="text-muted">Đơn hàng chưa có sản phẩm.</div>
            </c:when>
            <c:otherwise>
              <table class="table table-bordered align-middle">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                  </tr>
                </thead>
                <tbody>
                  <c:set var="i" value="0"/>
                  <c:set var="grand" value="0"/>
                  <c:forEach items="${items}" var="it">
                    <c:set var="i" value="${i + 1}"/>
                    <tr>
                      <td>${i}</td>
                      <td>
                        <c:if test="${not empty it.products.image}">
                          <img class="thumb" src="${pageContext.request.contextPath}/img/${it.products.image}" alt="${it.products.name}" />
                        </c:if>
                      </td>
                      <td>${it.products.name}</td>
                      <td><fmt:formatNumber value="${it.price * 1000}" type="currency" currencyCode="VND"/></td>
                      <td>${it.quantity}</td>
                     <td>
                       <fmt:formatNumber value="${(it.price * it.quantity) * 1000}" type="currency" currencyCode="VND"/>
                       <c:set var="grand" value="${grand + (it.price * it.quantity) * 1000}"/>
                     </td>
                    </tr>
                  </c:forEach>
                </tbody>
                <tfoot>
                  <tr>
                    <th colspan="5" class="text-end">Total</th>
                    <th><fmt:formatNumber value="${grand}" type="currency" currencyCode="VND"/></th>
                  </tr>
                </tfoot>
              </table>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>

    <%@include file="../inc/footer.jsp" %>
  </div>
</div>

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/chart/chart.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/easing/easing.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/waypoints/waypoints.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/owl.carousel.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/js/moment.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/js/moment-timezone.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="${pageContext.request.contextPath}/assets/admin/js/main.js"></script>
</body>
</html>