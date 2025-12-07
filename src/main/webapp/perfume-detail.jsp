<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>${perfume.name} - Chi tiết nước hoa</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="./inc/header.jsp" />

    <div class="container-fluid py-5">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="HomeServlet">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="PerfumeServlet">Nước hoa</a></li>
                    <li class="breadcrumb-item active">${perfume.name}</li>
                </ol>
            </nav>

            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="card">
                        <c:choose>
                            <c:when test="${not empty perfume.image}">
                                <img src="${pageContext.request.contextPath}/img/${perfume.image}" 
                                     class="card-img-top" alt="${perfume.name}" 
                                     style="width: 100%; height: auto; object-fit: contain;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/img/no-image.jpg" 
                                     class="card-img-top" alt="No image">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-lg-6">
                    <h2 class="mb-3">${perfume.name}</h2>
                    <p class="text-muted mb-3">Thương hiệu: <strong>${perfume.brand}</strong></p>
                    
                    <div class="mb-3">
                        <c:choose>
                            <c:when test="${perfume.price_old > 0 && perfume.price_old > perfume.price}">
                                <h3 class="text-danger mb-2">
                                    <fmt:formatNumber value="${perfume.price * 1000}" type="currency" currencyCode="VND"/>
                                </h3>
                                <p class="text-muted">
                                    <span class="text-decoration-line-through">
                                        <fmt:formatNumber value="${perfume.price_old * 1000}" type="currency" currencyCode="VND"/>
                                    </span>
                                    <span class="badge bg-danger ms-2">-${perfume.discountPercent}%</span>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <h3 class="text-primary mb-3">
                                    <fmt:formatNumber value="${perfume.price * 1000}" type="currency" currencyCode="VND"/>
                                </h3>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="mb-4">
                        <table class="table table-borderless">
                            <tr>
                                <td width="150"><strong>Dung tích:</strong></td>
                                <td>${perfume.volume}ml</td>
                            </tr>
                            <tr>
                                <td><strong>Giới tính:</strong></td>
                                <td>${perfume.gender}</td>
                            </tr>
                            <tr>
                                <td><strong>Loại hương:</strong></td>
                                <td>${perfume.scent_type}</td>
                            </tr>
                            <tr>
                                <td><strong>Tình trạng:</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${perfume.quantity > 0}">
                                            <span class="badge bg-success">Còn hàng (${perfume.quantity})</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>Lượt xem:</strong></td>
                                <td>${perfume.view}</td>
                            </tr>
                        </table>
                    </div>

                    <c:if test="${perfume.quantity > 0}">
                        <div class="mb-4">
                            <form action="CartServlet" method="post" class="d-flex align-items-center">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${perfume.id}">
                                <input type="number" name="quantity" value="1" min="1" max="${perfume.quantity}" 
                                       class="form-control me-3" style="width: 100px;">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">Mô tả sản phẩm</h4>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty perfume.description}">
                                    <p>${perfume.description}</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted">Chưa có mô tả cho sản phẩm này.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="./inc/footer.jsp" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
