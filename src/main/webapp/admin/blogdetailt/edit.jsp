<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Sửa Blog Detail - Admin</title>
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
        .container-fluid { padding: 20px; }
        @media (max-width: 991.98px) { #content { margin-left: 0; width: 100%; } }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <%@include file="../inc/sidebar.jsp" %>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <%@include file="../inc/navbar.jsp" %>
                <div class="container-fluid" style="margin-left: 0; padding-left: 15px;">
                    <div class="mb-3">
                        <h1 class="h3 mb-1 text-gray-800">Sửa Blog Detail</h1>
                        <p class="mb-0 text-muted">Chỉnh sửa nội dung chi tiết bài viết</p>
                    </div>
                    
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Thông tin chi tiết</h6>
                        </div>
                        <div class="card-body">
                            <form action="EditBlogDetailtServlet" method="post">
                                <input type="hidden" name="id" value="${blogDetailt.id}" />
                                
                                <div class="mb-3">
                                    <label for="blog_id" class="form-label">Blog ID</label>
                                    <input type="number" class="form-control" id="blog_id" name="blog_id" 
                                           value="${blogDetailt.blog_id}" readonly />
                                    <small class="text-muted">Không thể thay đổi Blog ID</small>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="content" class="form-label">Nội dung <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="content" name="content" rows="10" required>${blogDetailt.content}</textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Ngày tạo</label>
                                    <input type="text" class="form-control" value="${blogDetailt.created_at}" readonly />
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Ngày cập nhật</label>
                                    <input type="text" class="form-control" value="${blogDetailt.updated_at}" readonly />
                                </div>
                                
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle"></i> Cập nhật
                                    </button>
                                    <a href="IndexBlogDetailtServlet" class="btn btn-secondary">
                                        <i class="bi bi-x-circle"></i> Hủy
                                    </a>
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
