<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Banner Management - Admin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

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

    <style>
        /* Fix sidebar overlap issue */
        #content {
            margin-left: 250px; /* Adjust based on sidebar width */
            width: calc(100% - 250px);
        }
        @media (max-width: 768px) {
            #content { margin-left: 0; width: 100%; }
        }
        .container-fluid { padding: 20px; }

        /* Toggle switch styling */
        .form-switch .form-check-input {
            width: 3rem; height: 1.5rem; background-color: #dc3545;
            border: none; border-radius: 1rem; transition: all 0.3s ease;
        }
        .form-switch .form-check-input:checked {
            background-color: #198754; border-color: #198754;
        }
        .form-switch .form-check-input:focus {
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }
        .status-text { font-size: 0.875rem; font-weight: 500; margin-left: 0.5rem; }

        /* Table UI */
        .table thead th { white-space: nowrap; }
        .banner-thumb {
            width: 72px; height: 48px; object-fit: cover; border-radius: .25rem; border: 1px solid #e9ecef;
        }
        .table-search { max-width: 360px; }
        .actions a { margin: 0 6px; }
    </style>
</head>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
    <!-- Sidebar -->
    <%@include file="../inc/sidebar.jsp" %>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
            <!-- Topbar -->
            <%@include file="../inc/navbar.jsp" %>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid" style="margin-left: 0; padding-left: 15px;">
                <!-- Page Heading -->
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <div>
                        <h1 class="h3 mb-1 text-gray-800">Banners</h1>
                        <p class="mb-0 text-muted">Danh sách banner hiển thị tại trang chủ.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <form class="d-none d-sm-flex" method="get" action="${pageContext.request.contextPath}/IndexBannerServlet">
                            <input name="q" value="${param.q}" type="search" class="form-control form-control-sm table-search"
                                   placeholder="Tìm kiếm tiêu đề...">
                        </form>
                        <a href="${pageContext.request.contextPath}/CreateBannerServlet" class="btn btn-sm btn-primary">
                            <i class="bi bi-plus-lg me-1"></i>Thêm Banner
                        </a>
                    </div>
                </div>

                <!-- Data Table -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Banner Table</h6>
                        <div class="small text-muted">
                            <c:choose>
                                <c:when test="${not empty bannerList}">${fn:length(bannerList)} kết quả</c:when>
                                <c:otherwise>0 kết quả</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered align-middle" id="dataTable" width="100%" cellspacing="0">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width:60px;">STT</th>
                                        <th style="width:100px;">Image</th>
                                        <th>Title</th>
                                        <th style="width:200px;">Status</th>
                                        <th style="width:60px;" class="text-center">Sửa</th>
                                        <th style="width:60px;" class="text-center">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty bannerList}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">Chưa có banner nào.</td>
                                        </tr>
                                    </c:if>

                                    <c:set var="index" value="0"/>
                                    <c:forEach items="${bannerList}" var="banner">
                                        <c:set var="index" value="${index + 1}"/>
                                        <tr>
                                            <td>${index}</td>
                                            <td>
                                                <img class="banner-thumb"
                                                     src="${pageContext.request.contextPath}/img/${banner.image}"
                                                     alt="${banner.title}"/>
                                            </td>
                                            <td>
                                                <div class="fw-semibold">${banner.title}</div>
                                                <div class="text-muted small">ID: ${banner.id}</div>
                                            </td>
                                            <td>
                                                <div class="form-check form-switch d-flex align-items-center">
                                                    <input class="form-check-input" type="checkbox"
                                                           id="status_${banner.id}"
                                                           <c:if test='${banner.status}'>checked</c:if>
                                                           onchange="toggleStatus('${banner.id}')">
                                                    <label class="form-check-label ms-2" for="status_${banner.id}">
                                                        <span class="status-text">
                                                            <c:choose>
                                                                <c:when test='${banner.status}'>Hoạt động</c:when>
                                                                <c:otherwise>Không hoạt động</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td class="text-center actions">
                                                <a class="text-primary" title="Sửa"
                                                   href="${pageContext.request.contextPath}/EditBannerServlet?bannerId=${banner.id}">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                            </td>
                                            <td class="text-center actions">
                                                <a class="text-danger" title="Xóa"
                                                   href="${pageContext.request.contextPath}/DeleteBannerServlet?bannerId=${banner.id}"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa banner này?');">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- End Table -->
            </div>
            <!-- /.container-fluid -->
            <!-- End of Main Content -->
        </div>

        <!-- Footer -->
        <%@include file="../inc/footer.jsp" %>
        <!-- End of Footer -->
    </div>
    <!-- End of Content Wrapper -->
</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

<!-- Bootstrap core JavaScript-->
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

<script>
    function toggleStatus(bannerId) {
        const checkbox = document.getElementById('status_' + bannerId);
        const statusText = checkbox.closest('.form-check').querySelector('.status-text');

        // Update text immediately for better UX
        statusText.textContent = checkbox.checked ? 'Hoạt động' : 'Không hoạt động';

        // Send AJAX request to toggle status
        fetch('${pageContext.request.contextPath}/ToggleBannerStatusServlet?bannerId=' + encodeURIComponent(bannerId), {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        })
        .then((res) => {
            if (!res.ok) throw new Error('Network response was not ok');
            return res.text();
        })
        .catch((err) => {
            console.error('Error:', err);
            // Revert on error
            checkbox.checked = !checkbox.checked;
            statusText.textContent = checkbox.checked ? 'Hoạt động' : 'Không hoạt động';
            alert('Có lỗi xảy ra khi cập nhật trạng thái. Vui lòng thử lại.');
        });
    }
</script>
</body>
</html>