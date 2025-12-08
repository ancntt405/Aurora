<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Thông tin cá nhân - AURORA</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        .profile-header {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
            padding: 60px 0;
            color: white;
        }
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            object-fit: cover;
        }
        .profile-card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            border: none;
            margin-top: -50px;
            background: white;
        }
        .info-label {
            font-weight: 600;
            color: #ff6b35;
            margin-bottom: 5px;
        }
        .info-value {
            color: #333;
            font-size: 16px;
            padding: 10px 15px;
            background: #fff8f5;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .edit-btn {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            color: white;
            font-weight: 600;
            transition: all 0.3s;
        }
        .edit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
        }
        .section-title {
            color: #ff6b35;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #ff6b35;
        }
        .badge.bg-primary {
            background: #ff6b35 !important;
        }
    </style>
</head>

<body>
    <jsp:include page="./inc/header.jsp" />

    <!-- Profile Header -->
    <div class="profile-header">
        <div class="container text-center">
            <img src="${pageContext.request.contextPath}/img/${not empty sessionScope.user.image ? sessionScope.user.image : 'avatar.jpg'}" 
                 alt="Avatar" class="profile-avatar mb-3">
            <h2 class="mb-2">${sessionScope.user.name != null ? sessionScope.user.name : 'Người dùng'}</h2>
            <p class="mb-0"><i class="fas fa-envelope me-2"></i>${sessionScope.user.email}</p>
        </div>
    </div>

    <!-- Profile Content -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card profile-card">
                    <div class="card-body p-4">
                        <h4 class="section-title">
                            <i class="fas fa-user-circle me-2"></i>Thông tin cá nhân
                        </h4>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-label">
                                    <i class="fas fa-user me-2"></i>Họ và tên
                                </div>
                                <div class="info-value">
                                    ${sessionScope.user.name != null ? sessionScope.user.name : 'Chưa cập nhật'}
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="info-label">
                                    <i class="fas fa-envelope me-2"></i>Email
                                </div>
                                <div class="info-value">
                                    ${sessionScope.user.email}
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="info-label">
                                    <i class="fas fa-phone me-2"></i>Số điện thoại
                                </div>
                                <div class="info-value">
                                    ${sessionScope.user.phone != null ? sessionScope.user.phone : 'Chưa cập nhật'}
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="info-label">
                                    <i class="fas fa-shield-alt me-2"></i>Vai trò
                                </div>
                                <div class="info-value">
                                    <span class="badge bg-primary">${sessionScope.user.role}</span>
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <div class="info-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Địa chỉ
                                </div>
                                <div class="info-value">
                                    ${sessionScope.user.address != null ? sessionScope.user.address : 'Chưa cập nhật'}
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="info-label">
                                    <i class="fas fa-calendar-plus me-2"></i>Ngày tạo tài khoản
                                </div>
                                <div class="info-value">
                                    ${sessionScope.user.created_at != null ? sessionScope.user.created_at : 'N/A'}
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="info-label">
                                    <i class="fas fa-calendar-check me-2"></i>Cập nhật lần cuối
                                </div>
                                <div class="info-value">
                                    ${sessionScope.user.updated_at != null ? sessionScope.user.updated_at : 'N/A'}
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/UserServlet" class="btn edit-btn me-2">
                                <i class="fas fa-edit me-2"></i>Chỉnh sửa thông tin
                            </a>
                            <a href="${pageContext.request.contextPath}/OrdersServlet" class="btn btn-outline-warning" style="border-radius: 25px; padding: 12px 30px; border-color: #ff6b35; color: #ff6b35;">
                                <i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Links -->
                <div class="row mt-4">
                    <div class="col-md-4 mb-3">
                        <div class="card text-center h-100" style="border-radius: 15px;">
                            <div class="card-body">
                                <i class="fas fa-heart fa-3x text-danger mb-3"></i>
                                <h5>Yêu thích</h5>
                                <p class="text-muted">Danh sách sản phẩm yêu thích</p>
                                <a href="${pageContext.request.contextPath}/WishlistServlet" class="btn btn-sm btn-outline-danger">Xem ngay</a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <div class="card text-center h-100" style="border-radius: 15px;">
                            <div class="card-body">
                                <i class="fas fa-shopping-cart fa-3x text-success mb-3"></i>
                                <h5>Giỏ hàng</h5>
                                <p class="text-muted">Sản phẩm trong giỏ hàng</p>
                                <a href="${pageContext.request.contextPath}/CartServlet" class="btn btn-sm btn-outline-success">Xem ngay</a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <div class="card text-center h-100" style="border-radius: 15px;">
                            <div class="card-body">
                                <i class="fas fa-box fa-3x mb-3" style="color: #ff6b35;"></i>
                                <h5>Đơn hàng</h5>
                                <p class="text-muted">Lịch sử mua hàng</p>
                                <a href="${pageContext.request.contextPath}/OrdersServlet" class="btn btn-sm" style="border: 1px solid #ff6b35; color: #ff6b35;">Xem ngay</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="./inc/footer.jsp" />

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/wow/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/counterup/counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>
