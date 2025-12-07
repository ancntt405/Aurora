<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Sửa Nước Hoa - Admin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/admin-fix.css" rel="stylesheet">
    <style>
        #content { margin-left: 250px; width: calc(100% - 250px); }
        @media (max-width: 991.98px) { #content { margin-left: 0; width: 100%; } }
        .current-image { max-width: 200px; margin-top: 10px; }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <%@include file="../inc/sidebar.jsp" %>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <%@include file="../inc/navbar.jsp" %>
                <div class="container-fluid" style="margin-left: 0; padding-left: 15px;">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h1 class="h3 mb-0 text-gray-800">Sửa Nước Hoa</h1>
                        <a href="IndexPerfumeServlet" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại
                        </a>
                    </div>
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form action="EditPerfumeServlet" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="perfumeId" value="${perfume.id}">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Tên nước hoa *</label>
                                            <input type="text" class="form-control" name="name" value="${perfume.name}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Thương hiệu *</label>
                                            <input type="text" class="form-control" name="brand" value="${perfume.brand}" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Giá (nghìn đồng) *</label>
                                            <input type="number" step="0.01" class="form-control" name="price" value="${perfume.price}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Giá cũ (nghìn đồng)</label>
                                            <input type="number" step="0.01" class="form-control" name="price_old" value="${perfume.price_old}">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label class="form-label">Số lượng *</label>
                                            <input type="number" class="form-control" name="quantity" value="${perfume.quantity}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label class="form-label">Dung tích (ml) *</label>
                                            <input type="number" class="form-control" name="volume" value="${perfume.volume}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label class="form-label">Danh mục *</label>
                                            <select class="form-control" name="category_id" required>
                                                <option value="">-- Chọn danh mục --</option>
                                                <c:forEach items="${categoryList}" var="cat">
                                                    <option value="${cat.id}" ${cat.id == perfume.category_id ? 'selected' : ''}>
                                                        ${cat.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Loại hương *</label>
                                            <input type="text" class="form-control" name="scent_type" value="${perfume.scent_type}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Giới tính *</label>
                                            <select class="form-control" name="gender" required>
                                                <option value="">-- Chọn giới tính --</option>
                                                <option value="Nam" ${perfume.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                                <option value="Nữ" ${perfume.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                                <option value="Unisex" ${perfume.gender == 'Unisex' ? 'selected' : ''}>Unisex</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <textarea class="form-control" name="description" rows="4">${perfume.description}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Hình ảnh</label>
                                    <input type="file" class="form-control" name="image" accept="image/*">
                                    <c:if test="${not empty perfume.image}">
                                        <img src="${pageContext.request.contextPath}/img/${perfume.image}" 
                                             alt="${perfume.name}" class="current-image" />
                                        <p class="text-muted mt-2">Hình ảnh hiện tại</p>
                                    </c:if>
                                </div>
                                <div class="text-end">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-save"></i> Cập nhật
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../inc/footer.jsp" %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
