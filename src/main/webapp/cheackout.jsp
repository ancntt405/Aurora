<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Trang thanh toán</h1>
        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">Trang chủ</a></li>
            <li class="breadcrumb-item active text-white">Thanh Toán</li>
        </ol>
    </div>
    <!-- Single Page Header End -->




    <!-- Checkout Page Start -->
    <div class="container-fluid bg-light overflow-hidden py-5">
        <div class="container py-5">
            <h1 class="mb-4 wow fadeInUp" data-wow-delay="0.1s">Thông tin thanh toán</h1>
            <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post">
                <div class="row g-5">
                    <div class="col-md-12 col-lg-6 col-xl-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="form-item">
                            <label class="form-label my-3">Họ và tên <sup>*</sup></label>
                            <input type="text" class="form-control" name="name" value="${sessionScope.user.name}" placeholder="Nhập họ và tên" required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">Email <sup>*</sup></label>
                            <input type="email" class="form-control" name="email" value="${sessionScope.user.email}" placeholder="name@example.com" required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">Số điện thoại <sup>*</sup></label>
                            <input type="tel" class="form-control" name="phone" value="${sessionScope.user.phone}" placeholder="0123 456 789" required>
                        </div>
                        <div class="form-item">
                            <label class="form-label my-3">Địa chỉ <sup>*</sup></label>
                            <input type="text" class="form-control" name="address" value="${sessionScope.user.address}" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành" required>
                        </div>
                    </div>
                    <div class="col-md-12 col-lg-6 col-xl-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr class="text-center">
                                        <th scope="col" class="text-start">Tên sản phẩm</th>
                                        <th scope="col">Mã</th>
                                        <th scope="col">Đơn giá</th>
                                        <th scope="col">SL</th>
                                        <th scope="col">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty sessionScope.cartItems}">
                                            <tr>
                                                <td colspan="5" class="text-center py-4">Giỏ hàng trống</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${sessionScope.cartItems}" var="ci">
                                                <tr class="text-center">
                                                    <th scope="row" class="text-start py-4">
                                                        ${ci.product.name}
                                                    </th>
                                                    <td class="py-4">#${ci.product.id}</td>
                                                    <td class="py-4">
                                                        <fmt:formatNumber value="${ci.orderItem.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                    </td>
                                                    <td class="py-4 text-center">${ci.orderItem.quantity}</td>
                                                    <td class="py-4">
                                                        <fmt:formatNumber value="${ci.orderItem.quantity * ci.orderItem.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    <tr>
                                        <th scope="row">
                                        </th>
                                        <td class="py-4"></td>
                                        <td class="py-4"></td>
                                        <td class="py-4">
                                            <p class="mb-0 text-dark py-2">Tạm tính</p>
                                        </td>
                                        <td class="py-4">
                                            <div class="py-2 text-center border-bottom border-top">
                                                <p class="mb-0 text-dark">
                                                    <fmt:formatNumber value="${sessionScope.total * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">
                                        </th>
                                        <td class="py-4">
                                            <p class="mb-0 text-dark text-uppercase py-2">Tổng cộng</p>
                                        </td>
                                        <td class="py-4"></td>
                                        <td class="py-4"></td>
                                        <td class="py-4">
                                            <div class="py-2 text-center border-bottom border-top">
                                                <p class="mb-0 text-dark">
                                                    <fmt:formatNumber value="${sessionScope.total * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-2">
                            <div class="col-12">
                                <div class="form-check text-start my-2">
                                    <input type="checkbox" class="form-check-input bg-primary border-0" id="Payments-1"
                                        name="Payments" value="Payments">
                                    <label class="form-check-label" for="Payments-1">Thanh toán bằng séc (demo)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-2">
                            <div class="col-12">
                                <div class="form-check text-start my-2">
                                    <input type="checkbox" class="form-check-input bg-primary border-0" id="Delivery-1"
                                        name="Delivery" value="Delivery">
                                    <label class="form-check-label" for="Delivery-1">Thanh toán khi nhận hàng (demo)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-2">
                            <div class="col-12">
                                <div class="form-check text-start my-2">
                                    <input type="checkbox" class="form-check-input bg-primary border-0" id="Paypal-1"
                                        name="Paypal" value="Paypal">
                                    <label class="form-check-label" for="Paypal-1">Paypal (demo)</label>
                                </div>
                            </div>
                        </div>
                        <div class="row g-4 text-center align-items-center justify-content-center pt-4">
                            <button type="submit"
                                class="btn btn-primary border-secondary py-3 px-4 text-uppercase w-100 text-primary">Đặt
                                hàng</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Checkout Page End -->

    <!-- Footer Start -->
        <%@include file='./inc/footer.jsp' %>
    <!-- Footer End -->


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