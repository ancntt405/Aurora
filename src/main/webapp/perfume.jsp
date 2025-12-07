<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Nước Hoa - Perfume Shop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="./inc/header.jsp" />

    <div class="container-fluid py-5">
        <div class="container">
            <div class="row">
                <!-- Sidebar Filter -->
                <div class="col-lg-3">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Bộ lọc</h5>
                        </div>
                        <div class="card-body">
                            <h6 class="mb-3">Giới tính</h6>
                            <div class="mb-3">
                                <a href="PerfumeServlet" class="btn btn-outline-primary btn-sm w-100 mb-2">Tất cả</a>
                                <a href="PerfumeServlet?gender=Nam" class="btn btn-outline-primary btn-sm w-100 mb-2">Nam</a>
                                <a href="PerfumeServlet?gender=Nữ" class="btn btn-outline-primary btn-sm w-100 mb-2">Nữ</a>
                                <a href="PerfumeServlet?gender=Unisex" class="btn btn-outline-primary btn-sm w-100">Unisex</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product List -->
                <div class="col-lg-9">
                    <div class="row mb-4">
                        <div class="col-12">
                            <h2 class="mb-3">Nước Hoa</h2>
                            <p class="text-muted">Tìm thấy ${perfumeList.size()} sản phẩm</p>
                        </div>
                    </div>

                    <div class="row g-4">
                        <c:choose>
                            <c:when test="${empty perfumeList}">
                                <div class="col-12">
                                    <div class="alert alert-info">Không có sản phẩm nào.</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${perfumeList}" var="perfume">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card h-100 shadow-sm">
                                            <a href="PerfumeDetailServlet?perfumeId=${perfume.id}">
                                                <c:choose>
                                                    <c:when test="${not empty perfume.image}">
                                                        <img src="${pageContext.request.contextPath}/img/${perfume.image}" 
                                                             class="card-img-top" alt="${perfume.name}" 
                                                             style="height: 300px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/img/no-image.jpg" 
                                                             class="card-img-top" alt="No image" 
                                                             style="height: 300px; object-fit: cover;">
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <div class="card-body">
                                                <p class="text-muted mb-1">${perfume.brand}</p>
                                                <h5 class="card-title">
                                                    <a href="PerfumeDetailServlet?perfumeId=${perfume.id}" 
                                                       class="text-dark text-decoration-none">
                                                        ${perfume.name}
                                                    </a>
                                                </h5>
                                                <p class="text-muted mb-2">
                                                    <small>${perfume.volume}ml | ${perfume.gender}</small>
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${perfume.price_old > 0 && perfume.price_old > perfume.price}">
                                                                <span class="text-danger fw-bold">
                                                                    <fmt:formatNumber value="${perfume.price * 1000}" type="currency" currencyCode="VND"/>
                                                                </span>
                                                                <br>
                                                                <small class="text-muted text-decoration-line-through">
                                                                    <fmt:formatNumber value="${perfume.price_old * 1000}" type="currency" currencyCode="VND"/>
                                                                </small>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-primary fw-bold">
                                                                    <fmt:formatNumber value="${perfume.price * 1000}" type="currency" currencyCode="VND"/>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <a href="PerfumeDetailServlet?perfumeId=${perfume.id}" 
                                                       class="btn btn-primary btn-sm">
                                                        <i class="fas fa-eye"></i> Xem
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="./inc/footer.jsp" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
