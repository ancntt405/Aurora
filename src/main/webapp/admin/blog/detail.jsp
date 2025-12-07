<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Chi tiết Blog - Admin</title>
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
                        <h1 class="h3 mb-0 text-gray-800">Chi tiết Blog</h1>
                        <div>
                            <a href="EditBlogServlet?blogId=${blog.id}" class="btn btn-info">
                                <i class="bi bi-pencil-square"></i> Sửa
                            </a>
                            <a href="IndexBlogServlet" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </div>
                    
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h5 class="m-0 font-weight-bold text-primary">${blog.title}</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty blog.image_url}">
                                <div class="mb-4">
                                    <img src="${pageContext.request.contextPath}/img/${blog.image_url}" 
                                         alt="${blog.title}" class="img-fluid" style="max-width: 500px;" />
                                </div>
                            </c:if>
                            
                            <div class="mb-4">
                                <h6 class="text-muted">Mô tả:</h6>
                                <p>${blog.description}</p>
                            </div>
                            
                            <hr>
                            
                            <div class="mb-4">
                                <h6 class="text-muted">Nội dung chi tiết:</h6>
                                <c:choose>
                                    <c:when test="${not empty blogDetailt}">
                                        <div class="border p-3 bg-light">
                                            ${blogDetailt.content}
                                        </div>
                                        <p class="text-muted mt-2">
                                            <small>Tạo lúc: ${blogDetailt.created_at}</small><br>
                                            <small>Cập nhật: ${blogDetailt.updated_at}</small>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted">Chưa có nội dung chi tiết.</p>
                                    </c:otherwise>
                                </c:choose>
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
