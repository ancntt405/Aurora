<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Liên hệ - Nước hoa</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <style>
      /* Map + form alignment */
      .contact .map-wrapper { height: 100%; min-height: 380px; }
      .contact .map-wrapper iframe { width: 100%; height: 100%; border: 0; border-radius: 8px; }
      @media (min-width: 992px) {
        .contact .form-col { padding-right: 12px; }
        .contact .map-col { padding-left: 12px; }
        .contact .map-wrapper { min-height: 420px; }
      }
    </style>
</head>

<body>

   <jsp:include page="./inc/header.jsp" />

    <!-- Navbar & Hero Start -->
       <div class="container-fluid nav-bar p-0">
           <div class="row gx-0 bg-primary px-5 align-items-center">
               <div class="col-lg-3 d-none d-lg-block">
                   <nav class="navbar navbar-light position-relative" style="width: 250px;">
                       <button class="navbar-toggler border-0 fs-4 w-100 px-0 text-start" type="button"
                           data-bs-toggle="collapse" data-bs-target="#allCat">
                           <h4 class="m-0"><i class="fa fa-bars me-2"></i>Tất cả danh mục</h4>
                       </button>
                       <div class="collapse navbar-collapse rounded-bottom" id="allCat">
                           <div class="navbar-nav ms-auto py-0">
                               <ul class="list-unstyled categories-bars">

                                <%
                                  java.util.List<an.dev.data.model.Category> categoryList =
                                  (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                                  int printed = 0;
                                  if (categoryList != null) {
                                  for (an.dev.data.model.Category cat : categoryList) {
                                  if (printed >= 10) break; // lấy 5 danh mục
                                 %>
                                   <li>
                                       <div class="categories-bars-item">
                                           <a href="${pageContext.request.contextPath}/HomeServlet?categoryId=<%= cat.id %>"><%= cat.name %></a>
                                           <span>(5)</span>
                                       </div>
                                   </li>
                                   <%
                                    printed++;
                                   }
                                }
                                %>
                               </ul>
                           </div>
                       </div>
                   </nav>
               </div>
               <div class="col-12 col-lg-9">
                   <nav class="navbar navbar-expand-lg navbar-light bg-primary ">
                       <a href="" class="navbar-brand d-block d-lg-none">
                           <h1 class="display-5 text-secondary m-0"><i
                                   class="fas fa-shopping-bag text-white me-2"></i>Electro</h1>
                           <!-- <img src="img/logo.png" alt="Logo"> -->
                       </a>
                       <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                           data-bs-target="#navbarCollapse">
                           <span class="fa fa-bars fa-1x"></span>
                       </button>
                       <div class="collapse navbar-collapse" id="navbarCollapse">
                           <div class="navbar-nav ms-auto py-0">
                               <a href="${pageContext.request.contextPath}/HomeServlet" class="nav-item nav-link active">Trang chủ</a>
                               <a href="${pageContext.request.contextPath}/ShopServlet" class="nav-item nav-link">Cửa Hàng</a>
                               <div class="nav-item dropdown">
                                   <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Trang</a>
                                   <div class="dropdown-menu m-0">
                                       <a href="${pageContext.request.contextPath}/CartServlet" class="dropdown-item">giỏ hàng</a>
                                       <a href="${pageContext.request.contextPath}/CheckoutServlet" class="dropdown-item">Thanh Toán</a>
                                   </div>
                               </div>
                               <a href="${pageContext.request.contextPath}/ContactServlet" class="nav-item nav-link me-2">Liên Hệ</a>
                               <div class="nav-item dropdown d-block d-lg-none mb-3">
                                   <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Tất cả danh mục</a>
                                   <div class="dropdown-menu m-0">
                                       <ul class="list-unstyled categories-bars">
                                          <%
                                          java.util.List<an.dev.data.model.Category> categoryListMobile =
                                              (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                                          int printedMobile = 0;
                                          if (categoryListMobile != null) {
                                              for (an.dev.data.model.Category cat : categoryListMobile) {
                                                  if (printedMobile >= 10) break; // lấy 10 danh mục
                                          %>
                                           <li>
                                               <div class="categories-bars-item">
                                                   <a href="${pageContext.request.contextPath}/HomeServlet?categoryId=<%= cat.id %>"><%= cat.name %></a>
                                                   <span>(5)</span>
                                               </div>
                                           </li>
                                            <%
                                                  printedMobile++;
                                              }
                                          }
                                          %>
                                       </ul>
                                   </div>
                               </div>
                           </div>
                           <a href="" class="btn btn-secondary rounded-pill py-2 px-4 px-lg-3 mb-3 mb-md-3 mb-lg-0"><i
                                   class="fa fa-mobile-alt me-2"></i> +0123 456 7890</a>
                       </div>
                   </nav>
               </div>
           </div>
       </div>
       <!-- Navbar & Hero End -->

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Liên Hệ</h1>
        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">Trang chủ</a></li>
            <li class="breadcrumb-item active text-white">Liên Hệ</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Contucts Start -->
    <div class="container-fluid contact py-5">
        <div class="container py-5">
            <div class="p-5 bg-light rounded">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 900px;">
                            <h4 class="text-primary border-bottom border-primary border-2 d-inline-block pb-2">Liên hệ ngay với chúng tôi</h4>

                        </div>
                    </div>
                    <div class="col-lg-7 form-col">
                        <h5 class="text-primary wow fadeInUp" data-wow-delay="0.1s">Kết nối với chúng tôi</h5>
                        <h1 class="display-5 mb-4 wow fadeInUp" data-wow-delay="0.3s">Gửi tin nhắn của bạn</h1>
                        <p class="mb-4 wow fadeInUp" data-wow-delay="0.5s">Biểu mẫu liên hệ hiện chưa được kích hoạt. Vui lòng liên hệ trực tiếp qua địa chỉ, email hoặc số điện thoại bên cạnh.</p>
                        <form>
                            <div class="row g-4 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="col-lg-12 col-xl-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="name" placeholder="Họ và tên">
                                        <label for="name">Họ và tên</label>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xl-6">
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" placeholder="Email">
                                        <label for="email">Email</label>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xl-6">
                                    <div class="form-floating">
                                        <input type="phone" class="form-control" id="phone" placeholder="Số điện thoại">
                                        <label for="phone">Số điện thoại</label>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xl-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="project" placeholder="Chủ đề">
                                        <label for="project">Chủ đề</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="subject" placeholder="Tiêu đề">
                                        <label for="subject">Tiêu đề</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea class="form-control" placeholder="Nhập nội dung tại đây" id="message"
                                            style="height: 160px"></textarea>
                                        <label for="message">Nội dung</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button class="btn btn-primary w-100 py-3">Gửi tin nhắn</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-5 wow fadeInUp map-col" data-wow-delay="0.2s">
                        <div class="h-100 rounded map-wrapper">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3826.3703240972027!2d107.58621877491272!3d16.45677578428022!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3141a147a7d5b6ef%3A0x5d979ce2bf59e050!2zNzAgTmd1eeG7hW4gSHXhu4csIFbEqW5oIE5pbmgsIEh14bq_LCBUaMOgbmggcGjhu5EgSHXhur8gNDkwMDAsIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1762334572952!5m2!1svi!2s" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="row g-4 align-items-center justify-content-center">
                            <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="rounded p-4">
                                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                        style="width: 70px; height: 70px;">
                                        <i class="fas fa-map-marker-alt fa-2x text-primary"></i>
                                    </div>
                                    <div>
                                        <h4>Địa chỉ</h4>
                                        <p class="mb-2">70 nguyễn huệ</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.3s">
                                <div class="rounded p-4">
                                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                        style="width: 70px; height: 70px;">
                                        <i class="fas fa-envelope fa-2x text-primary"></i>
                                    </div>
                                    <div>
                                        <h4>email</h4>
                                        <p class="mb-2">lehongan93tohuu@gmail.com</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6 col-xl-3 wow fadeInUp" data-wow-delay="0.5s">
                                <div class="rounded p-4">
                                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mb-4"
                                        style="width: 70px; height: 70px;">
                                        <i class="fa fa-phone-alt fa-2x text-primary"></i>
                                    </div>
                                    <div>
                                        <h4>Số điện thoại</h4>
                                        <p class="mb-2">(+012) 3456 7890</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Contuct End -->

      <%@include file='./inc/footer.jsp' %>


    <!-- Copyright Start -->
    <div class="container-fluid copyright py-4">
        <div class="container">
            <div class="row g-4 align-items-center">
                <div class="col-md-6 text-center text-md-start mb-md-0">
                    <span class="text-white"><a href="#" class="border-bottom text-white"><i
                                class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All right
                        reserved.</span>
                </div>
                <div class="col-md-6 text-center text-md-end text-white">

                    <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                    <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                    <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                    Designed By <a class="border-bottom text-white" href="https://htmlcodex.com">HTML Codex</a>.
                    Distributed By <a class="border-bottom text-white" href="https://themewagon.com">ThemeWagon</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>


    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>