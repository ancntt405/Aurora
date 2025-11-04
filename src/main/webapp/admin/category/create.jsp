<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>CornSalad Admin - Dashboard</title>
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


        <style>
            /* existing layout CSS kept */
            #content-wrapper { margin-left: 0 !important; width: 100% !important; margin-top: 0 !important; }
            .container-fluid { padding: 20px; margin-left: 0; width: 100%; margin-top: 0; }
            @media (min-width: 768px) {
                #content-wrapper { margin-left: 250px !important; width: calc(100% - 250px) !important; position: relative !important; z-index: 1 !important; }
                .container-fluid { margin-left: 0 !important; padding-left: 20px !important; padding-right: 20px !important; }
            }
            @media (max-width: 767px) {
                #content-wrapper { margin-left: 0 !important; width: 100% !important; }
            }
            body { overflow-x: hidden; }
            #wrapper { position: relative; }
            #content-wrapper { min-height: 100vh; }

            /* Upload area styling */
            .upload-area {
                border: 2px dashed #dee2e6;
                border-radius: 8px;
                padding: 18px;
                text-align: center;
                cursor: pointer;
                transition: all 0.2s ease;
                position: relative;
                background: #fff;
            }
            .upload-area:hover { border-color: #007bff; background-color: #f8f9fa; }
            .upload-area.dragover { border-color: #007bff; background-color: #eaf4ff; }
            .upload-instructions { margin: 0 0 8px 0; color: #6c757d; }
            .preview-image { max-width: 250px; max-height: 250px; margin-top: 10px; border-radius: 8px; display: block; margin-left: auto; margin-right: auto; }
            #choose-button { margin-top: 6px; }
            #remove-image { margin-top: 8px; }
            .d-none { display: none !important; }
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
                <!-- Topbar -->
                <%@include file="../inc/navbar.jsp" %>
                <!-- End of Topbar -->
                <!-- Main Content -->
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Tạo danh mục mới</h6>
                                </div>
                                <div class="card-body">

                                    <form action="CreateCategoryServlet" method="post" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group mb-3">
                                                    <label for="name" class="form-label">Tên danh mục</label>
                                                    <input type="text" name="name" id="name" class="form-control" placeholder="Nhập tên danh mục" required>
                                                </div>

                                                <div class="form-group mb-3">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="status" id="status" value="true" checked>
                                                        <label class="form-check-label" for="status">Trạng thái hoạt động</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group mb-3">
                                                    <label for="thumbnail" class="form-label">Hình ảnh (Upload)</label>

                                                    <!-- Upload area: click / drag & drop -->
                                                    <div id="upload-area" class="upload-area" role="button" aria-label="Upload image area">
                                                        <p id="upload-text" class="upload-instructions">Kéo & thả ảnh vào đây hoặc nhấn <strong>Chọn ảnh</strong></p>

                                                        <button type="button" id="choose-button" class="btn btn-sm btn-outline-primary">Chọn ảnh</button>

                                                        <!-- Hidden file input (server nhận tên field 'thumbnail') -->
                                                        <input type="file" name="thumbnail" id="thumbnail" accept="image/*" class="d-none">

                                                        <!-- Preview -->
                                                        <div id="preview-wrapper" class="d-none text-center">
                                                            <img id="preview-image" class="preview-image" alt="Preview" />
                                                            <div>
                                                                <button type="button" id="remove-image" class="btn btn-sm btn-danger">Xóa ảnh</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <small class="form-text text-muted">Chọn ảnh từ máy tính để upload</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-text text-danger mb-3">
                                            ${errorMessage}
                                            <c:remove var="errorMessage" scope="session" />
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save"></i> Tạo danh mục
                                            </button>
                                            <a href="IndexCategoryServlet" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left"></i> Quay lại
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End of Main Content -->
                <!-- Footer -->
                <%@include file="../inc/footer.jsp" %>
                <!-- End of Footer -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->
        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

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
            // Form validation (giữ nguyên)
            document.querySelector('form').addEventListener('submit', (e) => {
                const name = document.getElementById('name').value.trim();
                if (!name) {
                    e.preventDefault();
                    alert('Vui lòng nhập tên danh mục!');
                    return;
                }
                // (Lưu ý): nếu bạn muốn validate file trước khi submit, thêm ở đây
            });

            // Upload UI logic
            (function() {
                const uploadArea = document.getElementById('upload-area');
                const fileInput = document.getElementById('thumbnail');
                const chooseBtn = document.getElementById('choose-button');
                const previewWrapper = document.getElementById('preview-wrapper');
                const previewImage = document.getElementById('preview-image');
                const removeBtn = document.getElementById('remove-image');
                const uploadText = document.getElementById('upload-text');

                // Click handlers
                chooseBtn.addEventListener('click', () => fileInput.click());
                uploadArea.addEventListener('click', (e) => {
                    // tránh click trùng khi bấm nút
                    if (e.target === uploadArea) fileInput.click();
                });

                // File selected
                fileInput.addEventListener('change', () => {
                    const f = fileInput.files[0];
                    handleFile(f);
                });

                // Drag & drop
                uploadArea.addEventListener('dragover', (e) => {
                    e.preventDefault();
                    uploadArea.classList.add('dragover');
                });
                uploadArea.addEventListener('dragleave', () => {
                    uploadArea.classList.remove('dragover');
                });
                uploadArea.addEventListener('drop', (e) => {
                    e.preventDefault();
                    uploadArea.classList.remove('dragover');
                    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
                        fileInput.files = e.dataTransfer.files;
                        handleFile(e.dataTransfer.files[0]);
                        e.dataTransfer.clearData();
                    }
                });

                // Remove file
                removeBtn.addEventListener('click', () => {
                    fileInput.value = '';
                    previewImage.src = '';
                    previewWrapper.classList.add('d-none');
                    uploadText.classList.remove('d-none');
                });

                function handleFile(file) {
                    if (!file) return;
                    if (!file.type.startsWith('image/')) {
                        alert('Vui lòng chọn file ảnh (jpg, png, ...).');
                        fileInput.value = '';
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        previewImage.src = e.target.result;
                        previewWrapper.classList.remove('d-none');
                        uploadText.classList.add('d-none');
                    };
                    reader.readAsDataURL(file);
                }
            })();
        </script>
    </body>
</html>
