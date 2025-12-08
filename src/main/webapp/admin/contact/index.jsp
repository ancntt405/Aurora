<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Contact Management - Admin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/assets/admin/img/favicon.ico" rel="icon">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">
    <style>
        #content { margin-left: 250px; width: calc(100% - 250px); }
        @media (max-width: 991.98px) { #content { margin-left: 0; width: 100%; } }
        .badge-new { background-color: #dc3545; }
        .badge-read { background-color: #28a745; }
    </style>
</head>
<body>
    <div id="wrapper">
        <%@include file="../inc/sidebar.jsp" %>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <%@include file="../inc/navbar.jsp" %>
                <div class="container-fluid" style="margin-left: 0; padding-left: 15px;">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <h1 class="h3 mb-1 text-gray-800">Liên hệ</h1>
                            <p class="mb-0 text-muted">Quản lý tin nhắn liên hệ</p>
                        </div>
                    </div>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Danh sách tin nhắn</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" width="100%">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Tiêu đề</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày gửi</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty contactList}">
                                                <tr><td colspan="7" class="text-center py-4">Chưa có tin nhắn nào.</td></tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${contactList}" var="contact">
                                                    <tr>
                                                        <td>${contact.id}</td>
                                                        <td>${contact.name}</td>
                                                        <td>${contact.email}</td>
                                                        <td>${contact.subject}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${contact.status == 'new'}">
                                                                    <span class="badge badge-new">Mới</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-read">Đã đọc</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${contact.created_at}</td>
                                                        <td>
                                                            <a href="ViewContactServlet?id=${contact.id}" class="btn btn-sm btn-info" title="Xem">
                                                                <i class="fa fa-eye"></i>
                                                            </a>
                                                            <a href="DeleteContactServlet?id=${contact.id}" 
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
