<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Danh sách yêu thích - Wishlist</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .wishlist-item {
            transition: all 0.3s ease;
        }
        .wishlist-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="./inc/header.jsp" />

    <div class="container-fluid py-5">
        <div class="container">
            <div class="row mb-4">
                <div class="col-12">
                    <h2 class="mb-3"><i class="fas fa-heart text-danger me-2"></i>Danh sách yêu thích</h2>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="HomeServlet">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Yêu thích</li>
                        </ol>
                    </nav>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty wishlistItems}">
                    <div class="row">
                        <div class="col-12">
                            <div class="alert alert-info text-center py-5">
                                <i class="fas fa-heart fa-3x mb-3 text-muted"></i>
                                <h4>Danh sách yêu thích trống</h4>
                                <p class="mb-3">Bạn chưa có sản phẩm yêu thích nào</p>
                                <a href="ShopServlet" class="btn btn-primary">
                                    <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach items="${wishlistItems}" var="item">
                            <div class="col-md-6 col-lg-4 col-xl-3 wishlist-item-container">
                                <div class="card h-100 wishlist-item">
                                    <div class="position-relative">
                                        <c:choose>
                                            <c:when test="${not empty item.product.image}">
                                                <img src="${pageContext.request.contextPath}/img/${item.product.image}" 
                                                     class="card-img-top" alt="${item.product.name}" 
                                                     style="height: 250px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/img/no-image.jpg" 
                                                     class="card-img-top" alt="No image" 
                                                     style="height: 250px; object-fit: cover;">
                                            </c:otherwise>
                                        </c:choose>
                                        <button class="btn btn-danger btn-sm position-absolute top-0 end-0 m-2 remove-wishlist" 
                                                data-product-id="${item.product.id}">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <a href="DetailServlet?productId=${item.product.id}" 
                                               class="text-dark text-decoration-none">
                                                ${item.product.name}
                                            </a>
                                        </h5>
                                        <div class="mb-3">
                                            <c:choose>
                                                <c:when test="${item.product.price_old > 0 && item.product.price_old > item.product.price}">
                                                    <span class="text-danger fw-bold">
                                                        <fmt:formatNumber value="${item.product.price * 1000}" type="currency" currencyCode="VND"/>
                                                    </span>
                                                    <br>
                                                    <small class="text-muted text-decoration-line-through">
                                                        <fmt:formatNumber value="${item.product.price_old * 1000}" type="currency" currencyCode="VND"/>
                                                    </small>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-primary fw-bold">
                                                        <fmt:formatNumber value="${item.product.price * 1000}" type="currency" currencyCode="VND"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <form action="CartServlet" method="post" class="add-to-cart-form">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="productId" value="${item.product.id}">
                                            <input type="hidden" name="price" value="${item.product.price}">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="toast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-check-circle text-success me-2"></i>
                <strong class="me-auto">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body"></div>
        </div>
    </div>

    <jsp:include page="./inc/footer.jsp" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Remove from wishlist
            $('.remove-wishlist').click(function() {
                const productId = $(this).data('product-id');
                const container = $(this).closest('.wishlist-item-container');
                
                $.ajax({
                    url: 'WishlistServlet',
                    type: 'POST',
                    data: {
                        action: 'remove',
                        productId: productId
                    },
                    success: function(response) {
                        if (response.success) {
                            container.fadeOut(300, function() {
                                $(this).remove();
                                if ($('.wishlist-item-container').length === 0) {
                                    location.reload();
                                }
                            });
                            showToast(response.message, 'success');
                        } else {
                            showToast(response.message, 'error');
                        }
                    },
                    error: function() {
                        showToast('Có lỗi xảy ra', 'error');
                    }
                });
            });

            // Add to cart
            $('.add-to-cart-form').submit(function(e) {
                e.preventDefault();
                const form = $(this);
                
                $.ajax({
                    url: form.attr('action'),
                    type: 'POST',
                    data: form.serialize(),
                    success: function() {
                        showToast('Đã thêm vào giỏ hàng', 'success');
                    },
                    error: function() {
                        showToast('Có lỗi xảy ra', 'error');
                    }
                });
            });

            function showToast(message, type) {
                const toast = $('#toast');
                const toastBody = toast.find('.toast-body');
                const toastIcon = toast.find('.toast-header i');
                
                toastBody.text(message);
                
                if (type === 'success') {
                    toastIcon.removeClass('fa-times-circle text-danger').addClass('fa-check-circle text-success');
                } else {
                    toastIcon.removeClass('fa-check-circle text-success').addClass('fa-times-circle text-danger');
                }
                
                const bsToast = new bootstrap.Toast(toast[0]);
                bsToast.show();
            }
        });
    </script>
</body>
</html>
