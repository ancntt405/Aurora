<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>${blog.title} - AURORA</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        .blog-detail-img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 15px;
        }
        .blog-content {
            font-size: 16px;
            line-height: 1.8;
            color: #333;
        }
        .blog-meta {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>

<body>
    <jsp:include page="./inc/header.jsp" />

    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5">
        <div class="container text-center py-5">
            <h1 class="display-4 text-white mb-4 animated slideInDown">${blog.title}</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/BlogServlet">Blog</a></li>
                    <li class="breadcrumb-item text-white" aria-current="page">Chi tiết</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- Blog Detail Start -->
    <div class="container-fluid blog-detail py-5">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-8">
                    <div class="blog-detail-content">
                        <!-- Blog Image -->
                        <div class="mb-4">
                            <img src="${pageContext.request.contextPath}/img/${blog.image_url}" 
                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/blog-1.jpg';" 
                                 class="blog-detail-img" 
                                 alt="${blog.title}">
                        </div>
                        
                        <!-- Blog Meta -->
                        <div class="blog-meta mb-4">
                            <i class="fas fa-newspaper me-2 text-primary"></i>
                            <span class="me-3">Bài viết</span>
                        </div>
                        
                        <!-- Blog Description -->
                        <div class="mb-4">
                            <h4 class="mb-3">${blog.description}</h4>
                        </div>
                        
                        <!-- Blog Content -->
                        <div class="blog-content">
                            <c:choose>
                                <c:when test="${not empty blogDetailt}">
                                    <div style="white-space: pre-wrap;">${blogDetailt.content}</div>
                                </c:when>
                                <c:otherwise>
                                    <p>Nội dung chi tiết đang được cập nhật...</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Back Button -->
                        <div class="mt-5">
                            <a href="${pageContext.request.contextPath}/BlogServlet" class="btn btn-primary rounded-pill py-3 px-5">
                                <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar -->
                <div class="col-lg-4">
                    <div class="blog-sidebar">
                        <!-- Recent Posts -->
                        <div class="mb-5">
                            <h4 class="mb-4 border-bottom border-primary border-2 pb-2 d-inline-block">Bài viết khác</h4>
                            <div class="recent-posts">
                                <%
                                  java.util.List<an.dev.data.model.Blog> allBlogs = 
                                    an.dev.data.DatabaseDao.getInstance().getBlogDao().findAll();
                                  int count = 0;
                                  if (allBlogs != null) {
                                    for (an.dev.data.model.Blog otherBlog : allBlogs) {
                                      if (count >= 5) break;
                                      if (otherBlog.getId() != ((an.dev.data.model.Blog)request.getAttribute("blog")).getId()) {
                                        count++;
                                %>
                                <div class="d-flex mb-3 pb-3 border-bottom">
                                    <img src="${pageContext.request.contextPath}/img/<%= otherBlog.getImage_url() %>" 
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/blog-1.jpg';" 
                                         class="img-fluid rounded" 
                                         style="width: 80px; height: 80px; object-fit: cover;" 
                                         alt="<%= otherBlog.getTitle() %>">
                                    <div class="ms-3">
                                        <a href="${pageContext.request.contextPath}/BlogServlet?blogId=<%= otherBlog.getId() %>" 
                                           class="h6 d-block mb-2"><%= otherBlog.getTitle() %></a>
                                        <small class="text-muted"><%= otherBlog.getDescription().length() > 50 ? otherBlog.getDescription().substring(0, 50) + "..." : otherBlog.getDescription() %></small>
                                    </div>
                                </div>
                                <%
                                      }
                                    }
                                  }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog Detail End -->

    <jsp:include page="./inc/footer.jsp" />

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/wow/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/counterup/counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>
