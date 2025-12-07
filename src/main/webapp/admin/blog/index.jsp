<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Blog Management - Admin</title>
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
        .blog-img { width: 80px; height: 60px; object-fit: cover; }
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
                        <div>
                            <h1 class="h3 mb-1 text-gray-800">Blog</h1>
                            <p class="mb-0 text-muted">Quản lý bài viết</p>
                        </div>
                        <a href="CreateBlogServlet" class="btn btn-primary">
                            <i class="bi bi-plus-circle"></i> Thêm mới
                        </a>
                    </div>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Danh sách bài viết</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hình ảnh</th>
                                            <th>Tiêu đề</th>
                                            <th>Mô tả</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty blogList}">
                                                <tr><td colspan="5" class="text-center py-4">Chưa có bài viết nào.</td></tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${blogList}" var="blog">
                                                    <tr>
                                                        <td>${blog.id}</td>
                                                        <td>
                                                            <c:if test="${not empty blog.image_url}">
                                                                <img src="${pageContext.request.contextPath}/img/${blog.image_url}" 
                                                                     alt="${blog.title}" class="blog-img" />
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <a href="IndexBlogDetailtServlet?blogId=${blog.id}">${blog.title}</a>
                                                        </td>
                                                        <td>${blog.description}</td>
                                                        <td>
                                                            <a href="IndexBlogDetailtServlet?blogId=${blog.id}" class="btn btn-sm btn-primary" title="Xem chi tiết">
                                                                <i class="fa fa-eye"></i>
                                                            </a>
                                                            <a href="EditBlogServlet?blogId=${blog.id}" class="btn btn-sm btn-info" title="Sửa">
                                                                <i class="bi bi-pencil-square"></i>
                                                            </a>
                                                            <a href="DeleteBlogServlet?blogId=${blog.id}" 
                                                               class="btn btn-sm btn-danger" title="Xóa"
                                                               onclick="return confirm('Bạn có chắc muốn xóa?')">
                                                                <i class="fa fa-trash"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
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
