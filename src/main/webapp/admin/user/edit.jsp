<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <style>
        .card-custom {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .card-custom .card-header {
            background-color: #00A9E0; /* đồng bộ màu theme */
            color: #fff;
            font-weight: 600;
            text-align: center;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .btn-custom {
            background-color: #00A9E0; /* màu chính */
            border: none;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #008bbd; /* màu đậm hơn khi hover */
        }
    </style>
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

              <div class="container-fluid mt-4">
                  <div class="row justify-content-center">
                      <div class="col-lg-6 col-md-8">
                          <div class="card card-custom">
                              <div class="card-header">
                                  Create New User
                              </div>
                              <div class="card-body">
                                  <form action="CreateUserServlet" method="post">
                                      <!-- Email -->
                                      <div class="mb-3">
                                          <label for="email" class="form-label">Email</label>
                                          <input type="email" id="email" name="email" class="form-control" placeholder="Enter Email" required>
                                      </div>

                                      <!-- Password -->
                                      <div class="mb-3">
                                          <label for="password" class="form-label">Password</label>
                                          <input type="password" id="password" name="password" class="form-control" placeholder="Enter Password" required>
                                      </div>

                                      <!-- Repeat Password -->
                                      <div class="mb-3">
                                          <label for="repeatPass" class="form-label">Repeat Password</label>
                                          <input type="password" id="repeatPass" name="repeatPass" class="form-control" placeholder="Enter Repeat Password" required>
                                      </div>

                                      <!-- Role -->
                                      <div class="mb-3">
                                          <label for="role" class="form-label">Role</label>
                                          <select name="role" id="role" class="form-select">
                                              <option value="User">User</option>
                                              <option value="Admin">Admin</option>
                                          </select>
                                      </div>

                                      <!-- Error message -->
                                      <c:if test="${not empty errorMessage}">
                                          <div class="alert alert-danger py-2 mb-3">
                                              ${errorMessage}
                                              <c:remove var="errorMessage" scope="session"/>
                                          </div>
                                      </c:if>

                                      <!-- Submit -->
                                      <div class="d-grid">
                                          <button type="submit" class="btn btn-custom text-white">Create User</button>
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