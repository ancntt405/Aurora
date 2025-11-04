<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head><meta charset="utf-8">
                              <title>DASHMIN - Bootstrap Admin Template</title>
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
                                /* Keep edit content clear of the fixed sidebar and footer */
                                #content-wrapper { margin-left: 250px; padding: 20px; padding-bottom: 80px; }
                                @media (max-width: 991.98px) { #content-wrapper { margin-left: 0; } }
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
                    <div class="card shadow-sm">
                      <div class="card-header">
                        <h6 class="m-0 fw-bold">Edit Order</h6>
                      </div>
                      <div class="card-body">
                        <form action="EditOrderServlet" method="post">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <div class="mb-3">
                                <label class="form-label">Code</label>
                                <input type="text" name="code" class="form-control" placeholder="Enter Code" value="${order.code}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Status</label>
                                <select name="status" class="form-select">
                                    <option value="false" <c:if test="${!order.status}">selected</c:if>>Pending</option>
                                    <option value="true"  <c:if test="${order.status}">selected</c:if>>Completed</option>
                                </select>
                            </div>
                            <div class="form-text text-muted">
                                ${errorMessage}
                                <c:remove var="errorMessage" scope="session" />
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <a href="IndexOrderServlet" class="btn btn-outline-secondary ms-2">Back</a>
                        </form>
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