<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
      <head>
        <meta charset="utf-8">
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

            <!-- Libraries Stylesheet (assets) -->
            <link href="${pageContext.request.contextPath}/assets/admin/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/assets/admin/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

            <!-- Customized Bootstrap Stylesheet -->
            <link href="${pageContext.request.contextPath}/assets/admin/css/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="${pageContext.request.contextPath}/assets/admin/css/style.css" rel="stylesheet">

            <!-- Admin CSS Fix -->
            <link href="${pageContext.request.contextPath}/assets/admin/css/admin-fix.css" rel="stylesheet">

                    <style>
                      /* Ensure content area is not under the fixed sidebar */
                      #content { margin-left: 250px; width: calc(100% - 250px); }
                      .container-fluid { padding: 20px; }
                      @media (max-width: 991.98px) { /* Bootstrap lg breakpoint */
                        #content { margin-left: 0; width: 100%; }
                      }
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
                <!-- Main Content -->
                <div id="content">
                 <!-- Topbar -->
                    <%@include file="../inc/navbar.jsp" %>
                    <!-- End of Topbar -->
                <!-- Begin Page Content -->
                <div class="container-fluid" style="margin-left: 0; padding-left: 15px;">
                    <!-- Page Heading -->
                    <div class="d-flex align-items-center justify-content-between mb-3">
                      <div>
                        <h1 class="h3 mb-1 text-gray-800">Order</h1>
                        <p class="mb-0 text-muted">Danh sách các đơn hàng</p>
                      </div>
                    </div>
                    <!-- DataTales Example -->
                    <form action="IndexOrderServlet" method="post" class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Orders</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Code</th>
                                            <th>Status</th>
                                            <th>Email</th>
                                            <th>#</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="index" value="0"/>
                                        <c:choose>
                                          <c:when test="${empty orderList}">
                                            <tr><td colspan="6" class="text-center py-4">Không có đơn hàng nào.</td></tr>
                                          </c:when>
                                          <c:otherwise>
                                            <c:forEach items="${orderList}" var="order">
                                              <c:set var="index" value="${index + 1}"/>
                                              <tr>
                                                <td>${index}</td>
                                                <td><a href="OrderItemServlet?orderId=${order.id}">${order.code}</a></td>
                                                <td>
                                                  <c:choose>
                                                    <c:when test="${order.status}"><span class="badge bg-success">Completed</span></c:when>
                                                    <c:otherwise><span class="badge bg-warning text-dark">Pending</span></c:otherwise>
                                                  </c:choose>
                                                </td>
                                                <td>${emailByUserId[order.user_id]}</td>
                                               <td>
                                              <a href="EditOrderServlet?orderId=${order.id}">
                                                 <i class="bi bi-pencil-square"></i>
                                              </a>
                                              </td>
                                              <td>
                                              <a href="DeleteOrderServlet?OrderId=${order.id}" class="text-danger">
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
                    </form>
                </div>
                <!-- /.container-fluid -->
                <!-- End of Main Content -->
                </div>
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