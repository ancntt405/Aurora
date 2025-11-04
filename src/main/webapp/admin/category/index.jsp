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
                /* Fix sidebar overlap issue */
                #content {
                    margin-left: 250px; /* Adjust based on sidebar width */
                    width: calc(100% - 250px);
                    min-height: 100vh;
                }
                
                @media (max-width: 768px) {
                    #content {
                        margin-left: 0;
                        width: 100%;
                    }
                }
                
                /* Ensure proper spacing */
                .container-fluid {
                    padding: 20px;
                }
                
                /* Toggle switch styling */
                .form-switch .form-check-input {
                    width: 3rem;
                    height: 1.5rem;
                    background-color: #dc3545;
                    border: none;
                    border-radius: 1rem;
                    transition: all 0.3s ease;
                }
                
                .form-switch .form-check-input:checked {
                    background-color: #198754;
                    border-color: #198754;
                }
                
                .form-switch .form-check-input:focus {
                    box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
                }
                
                .status-text {
                    font-size: 0.875rem;
                    font-weight: 500;
                    margin-left: 0.5rem;
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
                    <h1 class="h3 mb-2 text-gray-800">Categories</h1>
                    <p class="mb-4">Danh sách các Loaị hàng cùng thuộc tính kèm theo trong CornSalad Store.</p>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Category Table</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Thumbnail</th>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th>#</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="index" value="0"/>
                                        <c:forEach items="${categoryList}" var="category">
                                        <c:set var="index" value="${index + 1}"/>
                                            <tr>
                                                <td>${index}</td>
                                                <td>
                                                    <img src="${pageContext.request.contextPath}/img/${category.thumbnail}" width="50" height="50" alt="alt"/>
                                                </td>
                                                <td>${category.name}</td>
                                                <td>
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" 
                                                               id="status_${category.id}" 
                                                               ${category.status ? 'checked' : ''}
                                                               onchange="toggleStatus('${category.id}')">
                                                        <label class="form-check-label" for="status_${category.id}">
                                                            <span class="status-text">${category.status ? 'Hoạt động' : 'Không hoạt động'}</span>
                                                        </label>
                                                    </div>
                                                </td>


                                                <td>
                                                    <a href="EditCategoryServlet?categoryId=${category.id}">
                                                       <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                     <a href="DeleteCategoryServlet?categoryId=${category.id}" class="text-danger">
                                                           <i class="fa fa-trash"></i>
                                                     </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    </div>
                    <!-- /.container-fluid -->
                    <!-- End of Main Content -->
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

            <script>
                function toggleStatus(categoryId) {
                    // Get the checkbox element
                    const checkbox = document.getElementById('status_' + categoryId);
                    const statusText = checkbox.nextElementSibling.querySelector('.status-text');
                    
                    // Update text immediately for better UX
                    if (checkbox.checked) {
                        statusText.textContent = 'Hoạt động';
                    } else {
                        statusText.textContent = 'Không hoạt động';
                    }
                    
                    // Send AJAX request to toggle status
                    fetch('${pageContext.request.contextPath}/ToggleCategoryStatusServlet?categoryId=' + categoryId, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        }
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(data => {
                        console.log('Status toggled successfully');
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        // Revert the toggle if there was an error
                        checkbox.checked = !checkbox.checked;
                        if (checkbox.checked) {
                            statusText.textContent = 'Hoạt động';
                        } else {
                            statusText.textContent = 'Không hoạt động';
                        }
                        alert('Có lỗi xảy ra khi cập nhật trạng thái. Vui lòng thử lại.');
                    });
                }
            </script>
    </body>
</html>