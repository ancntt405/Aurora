<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Edit Banner - Admin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" rel="icon">

    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries -->
    <link href="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Bootstrap & Template -->
    <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/admin-fix.css" rel="stylesheet">

    <style>
        #content { margin-left: 250px; width: calc(100% - 250px); }
        @media (max-width: 768px){ #content{ margin-left:0; width:100%; } }
        .container-fluid { padding: 20px; }
        .banner-preview {
            width: 100%; max-width: 520px; aspect-ratio: 16/9; object-fit: cover;
            border: 1px solid #e9ecef; border-radius: .5rem; background: #f8f9fa;
        }
        .form-switch .form-check-input { width: 3rem; height: 1.5rem; }
    </style>
</head>
<body id="page-top">
<div id="wrapper">
    <%@include file="../inc/sidebar.jsp"%>

    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@include file="../inc/navbar.jsp"%>

            <div class="container-fluid" style="margin-left:0; padding-left:15px;">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <div>
                        <h1 class="h3 mb-1 text-gray-800">Edit Banner</h1>
                        <p class="mb-0 text-muted">Chỉnh sửa thông tin banner.</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/IndexBannerServlet" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>
                </div>

                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Thông tin Banner</h6>
                    </div>
                    <div class="card-body">
                        <form id="bannerForm"
                              action="${pageContext.request.contextPath}/EditBannerServlet"
                              method="post" enctype="multipart/form-data">

                            <input type="hidden" name="bannerId" value="${banner.id}"/>

                            <!-- Title -->
                            <div class="mb-3">
                                <label for="title" class="form-label">Tiêu đề</label>
                                <input type="text" class="form-control" id="title" name="title"
                                       value="${banner.title}" placeholder="Nhập tiêu đề banner" required>
                            </div>

                            <!-- Image (optional change) -->
                            <div class="mb-3">
                                <label class="form-label">Ảnh hiện tại</label>
                                <div>
                                    <img class="banner-preview"
                                         src="${pageContext.request.contextPath}/assets/images/${banner.image}"
                                         alt="${banner.title}">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Chọn ảnh mới (tuỳ chọn)</label>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <input class="form-control" type="file" id="imageFile" name="file"
                                               accept="image/*">
                                        <div class="form-text">Để trống nếu muốn giữ ảnh cũ.</div>
                                    </div>
                                    <div class="col-md-6">
                                        <img id="preview" class="banner-preview"
                                             src="${pageContext.request.contextPath}/assets/images/${banner.image}"
                                             alt="Preview">
                                    </div>
                                </div>
                            </div>

                            <!-- Status -->
                            <div class="mb-4">
                                <label class="form-label d-block">Trạng thái</label>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="statusSwitch"
                                           <c:if test="${banner.status}">checked</c:if>>
                                    <label class="form-check-label" for="statusSwitch">Hoạt động</label>
                                </div>
                                <input type="hidden" id="status" name="status"
                                       value="<c:out value='${banner.status}'/>">
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-save me-1"></i> Lưu thay đổi
                                </button>
                                <a href="${pageContext.request.contextPath}/IndexBannerServlet" class="btn btn-outline-secondary">Hủy</a>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>

        <%@include file="../inc/footer.jsp"%>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/admin/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Preview ảnh mới (nếu chọn)
    const fileInput = document.getElementById('imageFile');
    const preview   = document.getElementById('preview');
    const statusSw  = document.getElementById('statusSwitch');
    const statusVal = document.getElementById('status');

    if (fileInput) {
        fileInput.addEventListener('change', (e) => {
            const file = e.target.files && e.target.files[0];
            if (!file) return;
            const reader = new FileReader();
            reader.onload = (ev) => { preview.src = ev.target.result; };
            reader.readAsDataURL(file);
        });
    }

    if (statusSw) {
        statusSw.addEventListener('change', () => {
            statusVal.value = statusSw.checked ? 'true' : 'false';
        });
    }
</script>
</body>
</html>