<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Electro - Electronics Website Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
     <jsp:include page="./inc/header.jsp" />

    <!-- Navbar & Hero Start -->
    <div class="container-fluid nav-bar p-0">
            <div class="row gx-0 bg-primary px-5 align-items-center">
                <div class="col-lg-3 d-none d-lg-block">
                    <nav class="navbar navbar-light position-relative" style="width: 250px;">
                        <button class="navbar-toggler border-0 fs-4 w-100 px-0 text-start" type="button"
                            data-bs-toggle="collapse" data-bs-target="#allCat">
                            <h4 class="m-0"><i class="fa fa-bars me-2"></i>Tất cả danh mục</h4>
                        </button>
                        <div class="collapse navbar-collapse rounded-bottom" id="allCat">
                            <div class="navbar-nav ms-auto py-0">
                                <ul class="list-unstyled categories-bars">

                                 <%
                                   java.util.List<an.dev.data.model.Category> categoryList =
                                   (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                                   int printed = 0;
                                   if (categoryList != null) {
                                   for (an.dev.data.model.Category cat : categoryList) {
                                   if (printed >= 10) break; // lấy 5 danh mục
                                  %>
                                    <li>
                                        <div class="categories-bars-item">
                                            <a href="${pageContext.request.contextPath}/HomeServlet?categoryId=<%= cat.id %>"><%= cat.name %></a>
                                            <span>(5)</span>
                                        </div>
                                    </li>
                                    <%
                                     printed++;
                                    }
                                 }
                                 %>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
                <div class="col-12 col-lg-9">
                    <nav class="navbar navbar-expand-lg navbar-light bg-primary ">
                        <a href="" class="navbar-brand d-block d-lg-none">
                            <h1 class="display-5 text-secondary m-0"><i
                                    class="fas fa-shopping-bag text-white me-2"></i>Electro</h1>
                            <!-- <img src="img/logo.png" alt="Logo"> -->
                        </a>
                        <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars fa-1x"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarCollapse">
                            <div class="navbar-nav ms-auto py-0">
                                <a href="${pageContext.request.contextPath}/HomeServlet" class="nav-item nav-link active">Trang chủ</a>
                                <a href="${pageContext.request.contextPath}/ShopServlet" class="nav-item nav-link">Cửa Hàng</a>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Trang</a>
                                    <div class="dropdown-menu m-0">
                                        <a href="${pageContext.request.contextPath}/CartServlet" class="dropdown-item">giỏ hàng</a>
                                        <a href="${pageContext.request.contextPath}/CheckoutServlet" class="dropdown-item">Thanh Toán</a>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/ContactServlet" class="nav-item nav-link me-2">Liên Hệ</a>
                                <div class="nav-item dropdown d-block d-lg-none mb-3">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Tất cả danh mục</a>
                                    <div class="dropdown-menu m-0">
                                        <ul class="list-unstyled categories-bars">
                                           <%
                                           java.util.List<an.dev.data.model.Category> categoryListMobile =
                                               (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                                           int printedMobile = 0;
                                           if (categoryListMobile != null) {
                                               for (an.dev.data.model.Category cat : categoryListMobile) {
                                                   if (printedMobile >= 10) break; // lấy 10 danh mục
                                           %>
                                            <li>
                                                <div class="categories-bars-item">
                                                    <a href="${pageContext.request.contextPath}/HomeServlet?categoryId=<%= cat.id %>"><%= cat.name %></a>
                                                    <span>(5)</span>
                                                </div>
                                            </li>
                                             <%
                                                   printedMobile++;
                                               }
                                           }
                                           %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <a href="" class="btn btn-secondary rounded-pill py-2 px-4 px-lg-3 mb-3 mb-md-3 mb-lg-0"><i
                                    class="fa fa-mobile-alt me-2"></i> +0123 456 7890</a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    <!-- Navbar & Hero End -->

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Giỏ hàng của bạn</h1>
        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">Trang chủ</a></li>
            <li class="breadcrumb-item active text-white">Trang giỏ hàng</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Cart Page Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Image</th>
                            <th scope="col">Name</th>
                            <th scope="col">Model</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total</th>
                            <th scope="col">Handle</th>
                        </tr>
                    </thead>
                    <tbody>
                      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                      <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                      <c:choose>
                        <c:when test="${empty cartItems}">
                          <tr><td colspan="6" class="text-center py-4">Giỏ hàng trống</td></tr>
                        </c:when>
                        <c:otherwise>
                          <c:forEach items="${cartItems}" var="ci">
                            <tr>
                              <td>
                                <c:set var="imgVal" value="${ci.product.image}"/>
                                <c:set var="imgSrc" value=""/>
                                <c:choose>
                                  <c:when test="${not empty imgVal and fn:startsWith(imgVal, 'http')}">
                                    <c:set var="imgSrc" value="${imgVal}"/>
                                  </c:when>
                                  <c:when test="${not empty imgVal and (fn:startsWith(imgVal, 'img/') or fn:startsWith(imgVal, 'assets/'))}">
                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/${imgVal}"/>
                                  </c:when>
                                  <c:otherwise>
                                    <c:set var="imgSrc" value="${pageContext.request.contextPath}/img/${imgVal}"/>
                                  </c:otherwise>
                                </c:choose>
                                <a href="${pageContext.request.contextPath}/DetailServlet?productId=${ci.product.id}">
                                  <img src="${imgSrc}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/product-1.png';" alt="${ci.product.name}" style="width:60px; height:60px; object-fit:cover; border-radius:6px;">
                                </a>
                              </td>
                              <th scope="row">
                                <a href="${pageContext.request.contextPath}/DetailServlet?productId=${ci.product.id}" class="text-decoration-none text-dark"><p class="mb-0 py-4">${ci.product.name}</p></a>
                              </th>
                              <td>
                                <p class="mb-0 py-4">#${ci.product.id}</p>
                              </td>
                              <td>
                                <p class="mb-0 py-4"><fmt:formatNumber value="${ci.orderItem.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></p>
                              </td>
                              <td>
                                <form class="input-group quantity py-4" style="width: 140px;" method="post" action="${pageContext.request.contextPath}/CartServlet">
                                  <input type="hidden" name="action" value="update">
                                  <input type="hidden" name="productId" value="${ci.product.id}">
                                  <button class="btn btn-sm btn-minus rounded-circle bg-light border" type="button" onclick="var i=this.parentElement.querySelector('input[name=quantity]'); var v=Math.max(1, parseInt(i.value||'1')-1); i.value=v; this.form.submit();"><i class="fa fa-minus"></i></button>
                                  <input name="quantity" type="text" class="form-control form-control-sm text-center border-0" value="${ci.orderItem.quantity}">
                                  <button class="btn btn-sm btn-plus rounded-circle bg-light border" type="button" onclick="var i=this.parentElement.querySelector('input[name=quantity]'); var v=Math.max(1, parseInt(i.value||'1')+1); i.value=v; this.form.submit();"><i class="fa fa-plus"></i></button>
                                </form>
                              </td>
                              <td>
                                <p class="mb-0 py-4"><fmt:formatNumber value="${ci.orderItem.quantity * ci.orderItem.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></p>
                              </td>
                              <td class="py-4">
                                <form method="post" action="${pageContext.request.contextPath}/CartServlet" onsubmit="return confirm('Xóa sản phẩm khỏi giỏ?')">
                                  <input type="hidden" name="action" value="delete">
                                  <input type="hidden" name="productId" value="${ci.product.id}">
                                  <button class="btn btn-md rounded-circle bg-light border" type="submit"><i class="fa fa-times text-danger"></i></button>
                                </form>
                              </td>
                            </tr>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="row g-4 justify-content-end">
                <div class="col-8"></div>
                <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                    <div class="bg-light rounded">
                        <div class="p-4">
                            <h1 class="display-6 mb-4">Tổng tiền</h1>
                            <c:set var="subtotal" value="${total}" />
                            <c:set var="shipping" value="0" />
                            <div class="d-flex justify-content-between mb-4">
                                <h5 class="mb-0 me-4">Tạm tính:</h5>
                                <p class="mb-0"><fmt:formatNumber value="${subtotal * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <h5 class="mb-0 me-4">Vận chuyển</h5>
                                <div>
                                    <p class="mb-0"><fmt:formatNumber value="${shipping * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></p>
                                </div>
                            </div>
                            <p class="mb-0 text-end">Miễn phí nội thành (demo).</p>
                        </div>
                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                            <h5 class="mb-0 ps-4 me-4">Tổng cộng</h5>
                            <p class="mb-0 pe-4"><fmt:formatNumber value="${(subtotal + shipping) * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></p>
                        </div>
                        <form method="post" action="${pageContext.request.contextPath}/CartServlet" class="mb-0 ms-4">
                            <input type="hidden" name="action" value="toCheckout">
                            <button class="btn btn-primary rounded-pill px-4 py-3 text-uppercase mb-4" type="submit">Thanh Toán</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Cart Page End -->

   <%@include file='./inc/footer.jsp' %>

    <!-- Copyright Start -->
    <div class="container-fluid copyright py-4">
        <div class="container">
            <div class="row g-4 align-items-center">
                <div class="col-md-6 text-center text-md-start mb-md-0">
                    <span class="text-white"><a href="#" class="border-bottom text-white"><i
                                class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All right
                        reserved.</span>
                </div>
                <div class="col-md-6 text-center text-md-end text-white">

                    <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                    <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                    <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                    Designed By <a class="border-bottom text-white" href="https://htmlcodex.com">HTML Codex</a>.
                    Distributed By <a class="border-bottom text-white" href="https://themewagon.com">ThemeWagon</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>


    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>