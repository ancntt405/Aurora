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
                <div class="container-fluid" style="margin-left: 260px; padding-top: 20px;">
                    <div class="card shadow-sm p-4">
                        <h4 class="mb-4">Chỉnh sửa danh mục</h4>

                        <form action="EditCategoryServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="categoryId" value="${category.id}">

                            <div class="form-group mb-3">
                                <label for="name">Tên danh mục</label>
                                <input type="text" name="name" class="form-control" value="${category.name}">
                            </div>

                            <div class="form-group mb-3">
                                <label for="thumbnail">Hình ảnh (Upload)</label>
                                <input type="file" name="thumbnail" class="form-control">

                                <c:if test="${not empty category.thumbnail}">
                                    <div class="mt-3">
                                        <p>Ảnh hiện tại:</p>
                                        <img src="${pageContext.request.contextPath}/img/${category.thumbnail}"
                                             alt="Thumbnail" style="max-width:200px; border:1px solid #ccc;">
                                    </div>
                                </c:if>
                            </div>

                            <div class="form-group form-check mb-3">
                                <input type="checkbox" name="status" class="form-check-input" id="status"
                                       <c:if test="${category.status}">checked</c:if>>
                                <label class="form-check-label" for="status">Trạng thái hoạt động</label>
                            </div>

                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                            <a href="IndexCategoryServlet" class="btn btn-secondary">Quay lại</a>
                        </form>

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
    </body>
</html>