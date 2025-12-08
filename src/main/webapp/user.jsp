<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Chỉnh sửa thông tin - AURORA</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

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
        .edit-profile-header {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
            padding: 40px 0;
            color: white;
        }
        .edit-card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            border: none;
            margin-top: -30px;
            background: white;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .form-control:focus {
            border-color: #ff6b35;
            box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
        }
        .save-btn {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c42 100%);
            border: none;
            padding: 12px 40px;
            border-radius: 25px;
            color: white;
            font-weight: 600;
            transition: all 0.3s;
        }
        .save-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
        }
        .cancel-btn {
            border: 2px solid #ff6b35;
            color: #ff6b35;
            padding: 12px 40px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .cancel-btn:hover {
            background: #ff6b35;
            color: white;
        }
    </style>
</head>

<body>
    <jsp:include page="./inc/header.jsp" />

    <!-- Edit Profile Header -->
    <div class="edit-profile-header">
        <div class="container text-center">
            <h2 class="mb-2"><i class="fas fa-user-edit me-2"></i>Chỉnh sửa thông tin cá nhân</h2>
            <p class="mb-0">Cập nhật thông tin của bạn</p>
        </div>
    </div>

    <!-- Edit Form -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card edit-card">
                    <div class="card-body p-4">
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <form action="UserServlet" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="name" class="form-label">
                                        <i class="fas fa-user me-2 text-warning"></i>Họ và tên
                                    </label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${sessionScope.user.name}" placeholder="Nhập họ và tên">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-2 text-warning"></i>Email
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${sessionScope.user.email}" readonly>
                                    <small class="text-muted">Email không thể thay đổi</small>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">
                                        <i class="fas fa-phone me-2 text-warning"></i>Số điện thoại
                                    </label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${sessionScope.user.phone}" placeholder="Nhập số điện thoại">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="role" class="form-label">
                                        <i class="fas fa-shield-alt me-2 text-warning"></i>Vai trò
                                    </label>
                                    <input type="text" class="form-control" id="role" 
                                           value="${sessionScope.user.role}" readonly>
                                    <small class="text-muted">Vai trò không thể thay đổi</small>
                                </div>
                                
                                <div class="col-12 mb-3">
                                    <label for="address" class="form-label">
                                        <i class="fas fa-map-marker-alt me-2 text-warning"></i>Địa chỉ
                                    </label>
                                    <textarea class="form-control" id="address" name="address" rows="3" 
                                              placeholder="Nhập địa chỉ của bạn">${sessionScope.user.address}</textarea>
                                </div>
                            </div>
                            
                            <div class="text-center mt-4">
                                <button type="submit" class="btn save-btn me-2">
                                    <i class="fas fa-save me-2"></i>Lưu thay đổi
                                </button>
                                <a href="${pageContext.request.contextPath}/ProfileServlet" class="btn cancel-btn">
                                    <i class="fas fa-times me-2"></i>Hủy
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Change Password Section -->
                <div class="card mt-4" style="border-radius: 15px;">
                    <div class="card-body p-4">
                        <h5 class="mb-3" style="color: #ff6b35;">
                            <i class="fas fa-lock me-2"></i>Đổi mật khẩu
                        </h5>
                        <p class="text-muted">Để đảm bảo an toàn, vui lòng liên hệ quản trị viên để đổi mật khẩu.</p>
                        <a href="${pageContext.request.contextPath}/ContactServlet" class="btn btn-sm btn-outline-warning">
                            <i class="fas fa-envelope me-2"></i>Liên hệ hỗ trợ
                        </a>
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
