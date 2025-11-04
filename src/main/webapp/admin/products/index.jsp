<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>PRODUCTS</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

     <!-- Favicon -->
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

</head>
<style>
/* Toggle switch styling */
                .form-switch .form-check-input {
                    width: 3rem;
                    height: 1.5rem;
                    background-color: #dc3545;
                    border: none;
                    border-radius: 1rem;
                    transition: all 0.3s ease;
                }

                .form-switch .form-check-input:checked {
                    background-color: #198754;
                    border-color: #198754;
                }

                .form-switch .form-check-input:focus {
                    box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
                }

                .status-text {
                    font-size: 0.875rem;
                    font-weight: 500;
                    margin-left: 0.5rem;
                }
</style>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">

        <!-- Sidebar Start -->
        <%@include file="../inc/sidebar.jsp"%>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content" style="margin-left: 250px; width: calc(100% - 250px);">
            <!-- Navbar Start -->
            <%@include file="../inc/navbar.jsp" %>
            <!-- Navbar End -->

            <!-- Products Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Danh sách sản phẩm</h6>
                        <a href="CreateProductServlet" class="btn btn-primary">Thêm sản phẩm mới</a>
                    </div>
                    
                    <p><b>Số sản phẩm:</b> ${fn:length(productsList)}</p>
                    
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col" style="width: 5%">STT</th>
                                    <th scope="col" style="width: 10%">Hình ảnh</th>
                                    <th scope="col" style="width: 20%">Tên sản phẩm</th>
                                    <th scope="col" style="width: 20%">Mô tả</th>
                                    <th scope="col" style="width: 10%">Giá</th>
                                    <th scope="col" style="width: 10%">Giá cũ</th>
                                    <th scope="col" style="width: 5%">SL</th>
                                    <th scope="col" style="width: 10%">Danh mục</th>
                                    <th scope="col" style="width: 20%">Trạng Thái</th>
                                    <th scope="col" style="width: 5%">Sửa</th>
                                    <th scope="col" style="width: 5%">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="index" value="0"/>
                                <c:forEach items="${productsList}" var="product">
                                    <c:set var="index" value="${index + 1}"/>
                                    <tr>
                                        <td>${index}</td>
                                        <td><img src="assets/images/${product.image}" width="50" height="50" alt="img" class="img-fluid"/></td>
                                        <td>${product.name}</td>
                                        <td>${product.description}</td>
                                     <td>
                                        <fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                     </td>
                                     <td>
                                         <c:if test="${product.price_old > 0}">
                                             <del><fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></del>
                                         </c:if>
                                     </td>
                                        <td>${product.quantity}</td>
                                        <td>${product.categoryName}</td>
                                            <td>
                                             <div class="form-check form-switch">
                                               <input class="form-check-input" type="checkbox"
                                                id="status_${product.id}"
                                                ${product.status ? 'checked' : ''} disabled>
                                               <label class="form-check-label" for="status_${product.id}">
                                                <span class="status-text">${product.status ? 'Hoạt động' : 'Không hoạt động'}</span>
                                                </label>
                                                </div>
                                        </td>
                                        <td><a href="EditProductServlet?productId=${product.id}" class="btn btn-sm btn-primary"><i class="fas fa-edit"></i></a></td>
                                        <td><a href="DeleteProductServlet?productId=${product.id}" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Products End -->

            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            &copy; <a href="#">Shop</a>, All Right Reserved.
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            Designed By <a href="#">Shop Admin</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
  <!-- JavaScript Libraries -->
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