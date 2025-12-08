<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Chi tiết liên hệ - Admin</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">
    <style>
        #content { margin-left: 250px; width: calc(100% - 250px); }
        @media (max-width: 991.98px) { #content { margin-left: 0; width: 100%; } }
    </style>
</head>
<body>
    <div id="wrapper">
        <%@include file="../inc/sidebar.jsp" %>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <%@include file="../inc/navbar.jsp" %>
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">Chi tiết tin nhắn</h1>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Thông tin liên hệ</h6>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <strong>Tên:</strong> ${contact.name}
                                </div>
                                <div class="col-md-6">
                                    <strong>Email:</strong> 
                                    <a href="mailto:${contact.email}">${contact.email}</a>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <strong>Số điện thoại:</strong> 
                                    <c:choose>
                                        <c:when test="${not empty contact.phone}">
                                            <a href="tel:${contact.phone}">${contact.phone}</a>
                                        </c:when>
                                        <c:otherwise>Không có</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-md-6">
                                    <strong>Ngày gửi:</strong> ${contact.created_at}
                                </div>
                            </div>
                            <div class="mb-3">
                                <strong>Tiêu đề:</strong>
                                <p class="mt-2">${contact.subject}</p>
                            </div>
                            <div class="mb-3">
                                <strong>Nội dung:</strong>
                                <p class="mt-2" style="white-space: pre-wrap;">${contact.message}</p>
                            </div>
                            <div class="mt-4">
                                <a href="mailto:${contact.email}?subject=Re: ${contact.subject}" 
                                   class="btn btn-primary">
                                    <i class="fa fa-reply me-2"></i> Trả lời qua Email
                                </a>
                                <c:if test="${not empty contact.phone}">
                                    <a href="tel:${contact.phone}" class="btn btn-success">
                                        <i class="fa fa-phone me-2"></i> Gọi điện
                                    </a>
                                </c:if>
                                <a href="IndexContactServlet" class="btn btn-secondary">
                                    <i class="fa fa-arrow-left me-2"></i> Quay lại
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../inc/footer.jsp" %>
        </div>
    </div>
</body>
</html>
