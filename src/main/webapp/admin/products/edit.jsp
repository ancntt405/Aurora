<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit products</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/green-theme.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
    <%@ include file="../inc/sidebar.jsp" %>

    <div id="content-wrapper" class="d-flex flex-column">
        <%@ include file="../inc/navbar.jsp" %>

        <div class="container-fluid" style="margin-left: 0; padding-left: 20px;">
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-success">Chỉnh sửa sản phẩm</h1>
            </div>

            <!-- Debug info -->
            <c:if test="${not empty product}">
                <div class="alert alert-info">
                    <strong>Debug:</strong>
                    Product ID: ${product.id}, Name: ${product.name}, Categories: ${fn:length(categoryList)}
                </div>
            </c:if>

            <c:if test="${empty product}">
                <div class="alert alert-danger">Không có dữ liệu sản phẩm để hiển thị.</div>
            </c:if>

            <!-- Form Card -->
            <div class="card shadow mb-4">
                <div class="card-header py-3" style="background-color: #28a745; border-color: #28a745;">
                    <h6 class="m-0 font-weight-bold text-white">Thông tin sản phẩm</h6>
                </div>
                <div class="card-body">
                    <form action="EditProductServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="productId" value="${product.id}">

                        <!-- Current Images Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Ảnh chính hiện tại</label>
                                    <div class="border rounded p-3 text-center" style="min-height: 200px; background-color: #f8fff8; border-color: #28a745;">
                                        <c:if test="${not empty product.image}">
                                            <c:set var="imgSrc"
                                                   value="${fn:startsWith(product.image, 'http') ? product.image : pageContext.request.contextPath.concat('/assets/images/').concat(product.image)}"/>
                                            <img class="img-fluid rounded shadow-sm" style="max-height:180px; max-width: 100%; object-fit: contain;"
                                                 src="${imgSrc}" alt="Ảnh chính hiện tại"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='block';"/>
                                            <div class="mt-2" style="display: none;">
                                                <i class="fas fa-image fa-3x mb-2 text-warning"></i>
                                                <p class="font-weight-bold text-warning">Không thể hiển thị ảnh</p>
                                                <small>URL ảnh không hợp lệ hoặc không tồn tại</small>
                                            </div>
                                            <div class="mt-2">
                                                <small class="text-success font-weight-bold">
                                                    <i class="fas fa-check-circle"></i> Đã có ảnh chính
                                                </small>
                                                <br>
                                                <small class="text-muted">Ảnh: ${product.image}</small>
                                                <br>
                                                <small class="text-muted">Src hiển thị: ${imgSrc}</small>
                                            </div>
                                        </c:if>
                                        <c:if test="${empty product.image}">
                                            <div class="text-muted">
                                                <i class="fas fa-image fa-4x mb-3 text-success"></i>
                                                <p class="font-weight-bold text-success">Chưa có ảnh chính</p>
                                                <small>Vui lòng upload ảnh chính bên dưới</small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Gallery ảnh hiện tại</label>
                                    <div class="border rounded p-3" style="min-height: 200px; background-color: #f8fff8; border-color: #28a745;">
                                        <c:if test="${not empty galleries}">
                                            <div class="row">
                                                <c:forEach items="${galleries}" var="photo">
                                                    <div class="col-6 col-md-4 mb-2">
                                                        <div class="position-relative">
                                                            <img class="img-fluid rounded shadow-sm"
                                                                 style="max-height:80px; width: 100%; object-fit: cover;"
                                                                 src="${photo.image_url}"
                                                                 alt="Gallery ${photo.id}"
                                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='block';"/>
                                                            <div class="position-absolute top-0 end-0 bg-danger text-white rounded-circle"
                                                                 style="width: 20px; height: 20px; font-size: 10px; display: none;">
                                                                <i class="fas fa-exclamation"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div class="mt-2 text-center">
                                                <small class="text-success font-weight-bold">
                                                    <i class="fas fa-images"></i> ${fn:length(galleries)} ảnh trong gallery
                                                </small>
                                            </div>
                                        </c:if>
                                        <c:if test="${empty galleries}">
                                            <div class="text-center text-muted">
                                                <i class="fas fa-images fa-4x mb-3 text-success"></i>
                                                <p class="font-weight-bold text-success">Chưa có ảnh trong gallery</p>
                                                <small>Có thể upload gallery ảnh bên dưới</small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Upload Section -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Upload ảnh chính mới *</label>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="mainImage" name="mainImage" accept="image/*">
                                        <label class="custom-file-label" for="mainImage">Chọn ảnh chính...</label>
                                    </div>
                                    <small class="form-text text-muted">Chọn ảnh chính cho sản phẩm (bắt buộc)</small>

                                    <!-- Preview container for main image -->
                                    <div id="mainImagePreview" class="mt-3" style="display: none;">
                                        <div class="border rounded p-2 text-center" style="background-color: #f8fff8; border-color: #28a745;">
                                            <img id="mainImagePreviewImg" class="img-fluid rounded" style="max-height: 150px; max-width: 100%;" alt="Preview">
                                            <div class="mt-2">
                                                <small class="text-success font-weight-bold">
                                                    <i class="fas fa-eye"></i> Xem trước ảnh chính
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Upload gallery ảnh mới</label>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="galleryImages" name="photos" multiple accept="image/*">
                                        <label class="custom-file-label" for="galleryImages">Chọn nhiều ảnh...</label>
                                    </div>
                                    <small class="form-text text-muted">Có thể chọn nhiều ảnh cùng lúc (tùy chọn)</small>

                                    <!-- Preview container for gallery images -->
                                    <div id="galleryPreview" class="mt-3" style="display: none;">
                                        <div class="border rounded p-2" style="background-color: #f8fff8; border-color: #28a745;">
                                            <div id="galleryPreviewImages" class="row"></div>
                                            <div class="mt-2 text-center">
                                                <small class="text-success font-weight-bold">
                                                    <i class="fas fa-images"></i> <span id="galleryCount">0</span> ảnh đã chọn
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Product Information -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Tên sản phẩm * (tối đa 255 ký tự)</label>
                                    <input type="text" name="name" class="form-control" placeholder="Nhập tên sản phẩm" value="${product.name}" maxlength="255" required>
                                    <small class="form-text text-muted">Tên sản phẩm không được vượt quá 255 ký tự</small>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Danh mục *</label>
                                    <select name="categoryId" class="form-control" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach items="${categoryList}" var="cat">
                                            <option <c:if test="${cat.id == product.category_id}">selected</c:if> value="${cat.id}">
                                                ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="font-weight-bold">Mô tả sản phẩm *</label>
                            <textarea name="description" class="form-control" rows="3" placeholder="Nhập mô tả sản phẩm" required>${product.description}</textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="font-weight-bold">Giá bán *</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">₫</span>
                                        </div>
                                        <input type="number" name="price" min="0" step="0.01" class="form-control" placeholder="0" value="${product.price}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="font-weight-bold">Giá cũ</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">₫</span>
                                        </div>
                                        <input type="number" name="price_old" min="0" step="0.01" class="form-control" placeholder="0" value="${product.price_old}">
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="font-weight-bold">Số lượng *</label>
                                    <input type="number" name="quantity" min="0" class="form-control" placeholder="0" value="${product.quantity}" required>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="font-weight-bold">Lượt xem</label>
                                    <input type="number" name="view" min="0" class="form-control" placeholder="0" value="${product.view}">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="form-check">
                                <input type="checkbox" name="status" value="true" class="form-check-input" id="statusCheckbox"
                                       <c:if test="${product.status}">checked</c:if>>
                                <label class="form-check-label font-weight-bold" for="statusCheckbox">
                                    <i class="fas fa-eye text-success"></i> Hiển thị sản phẩm
                                </label>
                            </div>
                        </div>

                        <!-- Error Messages -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                            </div>
                        </c:if>
                        <c:if test="${not empty requestScope.errorMessage}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle"></i> ${requestScope.errorMessage}
                            </div>
                        </c:if>

                        <!-- Action Buttons -->
                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-success btn-lg mr-3" style="background-color: #28a745; border-color: #28a745;">
                                <i class="fas fa-save"></i> Lưu thay đổi
                            </button>
                            <a href="IndexProductsServlet" class="btn btn-outline-success btn-lg">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="/admin/inc/footer.jsp" %>
    </div>
</div>

<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

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

<!-- Custom JavaScript for file upload -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Main image file input
    const mainImageInput = document.getElementById('mainImage');
    if (mainImageInput) {
        const mainImageLabel = mainImageInput.nextElementSibling;

        mainImageInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                mainImageLabel.textContent = this.files[0].name;

                // Show preview
                const previewContainer = document.getElementById('mainImagePreview');
                const previewImg = document.getElementById('mainImagePreviewImg');

                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewContainer.style.display = 'block';
                };
                reader.readAsDataURL(this.files[0]);
            } else {
                mainImageLabel.textContent = 'Chọn ảnh chính...';
                document.getElementById('mainImagePreview').style.display = 'none';
            }
        });
    }

    // Gallery images file input
    const galleryInput = document.getElementById('galleryImages');
    if (galleryInput) {
        const galleryLabel = galleryInput.nextElementSibling;

        galleryInput.addEventListener('change', function() {
            if (this.files && this.files.length > 0) {
                if (this.files.length === 1) {
                    galleryLabel.textContent = this.files[0].name;
                } else {
                    galleryLabel.textContent = this.files.length + ' ảnh đã chọn';
                }
            } else {
                galleryLabel.textContent = 'Chọn nhiều ảnh...';
            }
        });
    }
});
</script>
</body>
</html>