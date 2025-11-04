<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>AURORA - Shop nước hoa hàng đầu việt nam</title>
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
    <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css?v=20250922" rel="stylesheet">
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
                            <a href="index.html" class="nav-item nav-link active">Trang chủ</a>
                            <a href="shop.html" class="nav-item nav-link">Cửa Hàng</a>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Trang</a>
                                <div class="dropdown-menu m-0">
                                    <a href="cart.jsp" class="dropdown-item">giỏ hàng</a>
                                    <a href="cheackout.jsp" class="dropdown-item">Thanh Toán</a>
                                </div>
                            </div>
                            <a href="contact.jsp" class="nav-item nav-link me-2">Liên Hệ</a>
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

    <!-- Carousel Start -->
    <div class="container-fluid carousel bg-light px-0">
        <div class="row g-0 justify-content-end align-items-stretch">
            <div class="col-12 col-lg-7 col-xl-9">
                <div class="header-carousel owl-carousel bg-light py-5">
                  <%
                    java.util.List<an.dev.data.model.Banner> bannerList =
                      (java.util.List<an.dev.data.model.Banner>) request.getAttribute("bannerList");
                    int count = 0;
                    if (bannerList != null) {
                      for (an.dev.data.model.Banner banner : bannerList) {
                        if (count >= 3) break;
                  %>
                    <div class="header-carousel-item">
                      <img src="${pageContext.request.contextPath}/img/<%= banner.getImage() %>" class="img-fluid w-100" alt="<%= banner.getTitle() %>">
                    </div>
                  <%
                        count++;
                      }
                    }
                  %>
                </div>
            </div>
            <div class="col-12 col-lg-5 col-xl-3 wow fadeInRight" data-wow-delay="0.1s">
                <div class="carousel-header-banner h-100">
                    <%
                      java.util.List<an.dev.data.model.Product> randomProductsHdr =
                        (java.util.List<an.dev.data.model.Product>) request.getAttribute("randomProducts");
                      an.dev.data.model.Product rph = null;
                      if (randomProductsHdr != null && !randomProductsHdr.isEmpty()) {
                        rph = randomProductsHdr.get(0);
                      }
                      if (rph == null) {
                        rph = (an.dev.data.model.Product) request.getAttribute("randomProduct");
                      }

                      java.util.List<an.dev.data.model.Category> catListHdr =
                        (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                      java.util.Map<Integer, String> catNameByIdHdr = new java.util.HashMap<>();
                      if (catListHdr != null) {
                        for (an.dev.data.model.Category c : catListHdr) {
                          catNameByIdHdr.put(c.getId(), c.getName());
                        }
                      }

                      java.text.DecimalFormatSymbols symH = new java.text.DecimalFormatSymbols();
                      symH.setGroupingSeparator('.');
                      symH.setDecimalSeparator(',');
                      java.text.DecimalFormat dfH = new java.text.DecimalFormat("#,##0.##", symH);
                    %>
                    <img src="<%= (rph != null && rph.getImage() != null && !rph.getImage().isEmpty()) ? (request.getContextPath()+"/img/"+rph.getImage()) : ("img/header-img.jpg") %>"
                         class="img-fluid w-100 h-100" style="object-fit: cover;" alt="Image">
                    <div class="carousel-banner-offer">
                        <p class="bg-primary text-white rounded fs-5 py-2 px-4 mb-0 me-3">Save $48.00</p>
                        <p class="text-primary fs-5 fw-bold mb-0">Special Offer</p>
                    </div>
                    <div class="carousel-banner">
                        <div class="carousel-banner-content text-center p-4">
                            <a href="#" class="d-block mb-2"><%= (rph != null) ? (catNameByIdHdr.getOrDefault(rph.getCategory_id(), "Unknown")) : "SmartPhone" %></a>
                            <a href="#" class="d-block text-white fs-3"><%= (rph != null) ? rph.getName() : "Apple iPad Mini <br> G2356" %></a>
                            <%
                              if (rph != null) {
                            %>
                              <del class="me-2 text-white fs-5"><%= dfH.format(rph.getPrice() * 1000) %>đ</del>
                              <% if (rph.getPrice_old() > 0) { %>
                                <span class="text-primary fs-5"><%= dfH.format(rph.getPrice_old() * 1000) %> đ</span>
                              <% } %>
                            <%
                              } else {
                            %>
                              <del class="me-2 text-white fs-5">$1,250.00</del>
                              <span class="text-primary fs-5">$1,050.00</span>
                            <%
                              }
                            %>
                        </div>
                        <a href="#" class="btn btn-primary rounded-pill py-2 px-4"><i
                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Carousel End -->

    <!-- Searvices Start -->
    <div class="container-fluid px-0">
        <div class="row g-0">
            <div class="col-6 col-md-4 col-lg-2 border-start border-end wow fadeInUp" data-wow-delay="0.1s">
                <div class="p-4">
                    <div class="d-inline-flex align-items-center">
                        <i class="fa fa-sync-alt fa-2x text-primary"></i>
                        <div class="ms-4">
                            <h6 class="text-uppercase mb-2">Hoàn trả miễn phí</h6>
                            <p class="mb-0">Đảm bảo hoàn tiền trong vòng 30 ngày!</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.2s">
                <div class="p-4">
                    <div class="d-flex align-items-center">
                        <i class="fab fa-telegram-plane fa-2x text-primary"></i>
                        <div class="ms-4">
                            <h6 class="text-uppercase mb-2">Miễn phí vận chuyển</h6>
                            <p class="mb-0">Miễn phí vận chuyển cho tất cả các đơn hàng</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.3s">
                <div class="p-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-life-ring fa-2x text-primary"></i>
                        <div class="ms-4">
                            <h6 class="text-uppercase mb-2">Hỗ trợ 24/7</h6>
                            <p class="mb-0">Chúng tôi hỗ trợ trực tuyến 24 giờ một ngày</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.4s">
                <div class="p-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-credit-card fa-2x text-primary"></i>
                        <div class="ms-4">
                            <h6 class="text-uppercase mb-2">Nhận thẻ quà tặng</h6>
                            <p class="mb-0">Nhận quà tặng trên đơn hàng $50</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.5s">
                <div class="p-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-lock fa-2x text-primary"></i>
                        <div class="ms-4">
                            <h6 class="text-uppercase mb-2">Thanh toán an toàn</h6>
                            <p class="mb-0">Chúng tôi coi trọng sự an toàn của bạn</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.6s">
                <div class="p-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-blog fa-2x text-primary"></i>
                        <div class="ms-4">
                            <h6 class="text-uppercase mb-2">Dịch vụ trực tuyến</h6>
                            <p class="mb-0">Sản phẩm được trả lại miễn phí trong 30 ngày</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Searvices End -->
    <!-- Our Products Start -->
    <div class="container-fluid product py-5">
        <div class="container py-5">
            <div class="tab-class">
                <div class="row g-4">
                    <div class="col-lg-4 text-start wow fadeInLeft" data-wow-delay="0.1s">
                        <h1>Sản phẩm của chúng tôi</h1>
                    </div>
                    <div class="col-lg-8 text-end wow fadeInRight" data-wow-delay="0.1s">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item mb-4">
                                <a class="d-flex mx-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill"
                                    href="#tab-1">
                                    <span class="text-dark" style="width: 130px;">Tất cả danh mục</span>
                                </a>
                            </li>
                          <%
                          Integer selCatId = (Integer) request.getAttribute("selectedCategoryId");
                          java.util.List<an.dev.data.model.Category> selCats =
                              (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                          if (selCats != null) {
                              for (an.dev.data.model.Category ctmp : selCats) {
                                  Integer id = ctmp.getId();
                                  boolean active = (selCatId != null && id == selCatId.intValue());
                          %>
                          <li class="nav-item mb-4">
                              <a class="d-flex mx-2 py-2 bg-light rounded-pill <%= active ? "active" : "" %>" data-bs-toggle="pill"
                                 href="${pageContext.request.contextPath}/HomeServlet?categoryId=<%= id %>">
                                  <span class="text-dark" style="width: 130px;"><%= ctmp.getName() %></span>
                              </a>
                          </li>
                          <%
                              }
                          }
                          %>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                             <%
                             // Lấy tất cả sản phẩm từ BaseServlet: attribute 'productList'
                            java.util.List<an.dev.data.model.Product> products =
                             (java.util.List<an.dev.data.model.Product>) request.getAttribute("productList");

                            // Build a map from category ID to category name to avoid querying per product
                            java.util.List<an.dev.data.model.Category> allCategories =
                             (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                            java.util.Map<Integer, String> categoryNameById = new java.util.HashMap<>();
                            if (allCategories != null) {
                                     for (an.dev.data.model.Category c : allCategories) {
                                     categoryNameById.put(c.getId(), c.getName());
                                    }
                            }

                            if (products != null && !products.isEmpty()) {
                            // Duyệt toàn bộ danh sách products
                            for (an.dev.data.model.Product product : products) {
                            %>
                            <div class="col-md-6 col-lg-4 col-xl-3">
                                <div class="product-item rounded wow fadeInUp" data-wow-delay="0.7s">
                                    <div class="product-item-inner border rounded">
                                        <div class="product-item-inner-item">
                                            <img src="${pageContext.request.contextPath}/img/<%= product.getImage() %>" class="img-fluid w-100 rounded-top" alt="<%= product.getName() %>">

                                            <div class="product-details">
                                                <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                            </div>
                                        </div>
                                        <div class="text-center rounded-bottom p-4">
                                            <a href="#" class="d-block mb-2"><%= product.getName() %></a>
                                            <a href="#" class="d-block h4"><%= categoryNameById.containsKey(product.getCategory_id()) ? categoryNameById.get(product.getCategory_id()) : "Unknown" %></a>
                                               <%
                                               java.text.DecimalFormatSymbols symbols = new java.text.DecimalFormatSymbols();
                                               symbols.setGroupingSeparator('.');
                                               symbols.setDecimalSeparator(',');

                                               java.text.DecimalFormat df = new java.text.DecimalFormat("#,##0.##", symbols);
                                               %>
                                            <del class="me-2 fs-5"><%= df.format(product.getPrice() * 1000) %>đ</del>
                                            <% if (product.getPrice_old() > 0) { %>
                                            <span class="text-primary fs-5"><%= df.format(product.getPrice_old() * 1000) %> đ</span>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div
                                        class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                        <a href="#"
                                            class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i
                                                class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex">
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star text-primary"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                            <div class="d-flex">
                                                <a href="#"
                                                    class="text-primary d-flex align-items-center justify-content-center me-3"><span
                                                        class="rounded-circle btn-sm-square border"><i
                                                            class="fas fa-random"></i></i></a>
                                                <a href="#"
                                                    class="text-primary d-flex align-items-center justify-content-center me-0"><span
                                                        class="rounded-circle btn-sm-square border"><i
                                                            class="fas fa-heart"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                 } // end for
                               } else {
                               out.println("<p>Không có sản phẩm nào có sẵn.</p>");
                                     }
                              %>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Product List Satrt -->
    <div class="container-fluid products productList overflow-hidden">
        <div class="container products-mini py-5">
            <div class="mx-auto text-center mb-5" style="max-width: 900px;">
                <h4 class="text-primary border-bottom border-primary border-2 d-inline-block p-2 title-border-radius wow fadeInUp"
                    data-wow-delay="0.1s">Sản phẩm</h4>
                <h1 class="mb-0 display-3 wow fadeInUp" data-wow-delay="0.3s">Tất cả sản phẩm</h1>
            </div>
            <div class="productList-carousel owl-carousel pt-4 wow fadeInUp" data-wow-delay="0.3s">
                <div class="productImg-carousel owl-carousel productList-item">
                  <%
                    java.util.List<an.dev.data.model.Product> allProducts =
                      (java.util.List<an.dev.data.model.Product>) request.getAttribute("productList");

                    java.util.List<an.dev.data.model.Category> catListAll =
                      (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                    java.util.Map<Integer, String> catNameById2 = new java.util.HashMap<>();
                    if (catListAll != null) {
                      for (an.dev.data.model.Category c : catListAll) {
                        catNameById2.put(c.getId(), c.getName());
                      }
                    }

                    java.text.DecimalFormatSymbols symbols2 = new java.text.DecimalFormatSymbols();
                    symbols2.setGroupingSeparator('.');
                    symbols2.setDecimalSeparator(',');
                    java.text.DecimalFormat df2 = new java.text.DecimalFormat("#,##0.##", symbols2);

                    if (allProducts != null && !allProducts.isEmpty()) {
                      for (an.dev.data.model.Product p : allProducts) {
                  %>
                  <div class="productImg-item products-mini-item border">
                    <div class="row g-0">
                      <div class="col-5">
                        <div class="products-mini-img border-end h-100">
                          <img src="${pageContext.request.contextPath}/img/<%= p.getImage() %>" class="img-fluid w-100 h-100" alt="<%= p.getName() %>">
                          <div class="products-mini-icon rounded-circle bg-primary">
                            <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                          </div>
                        </div>
                      </div>
                      <div class="col-7">
                        <div class="products-mini-content p-3">
                          <a href="#" class="d-block mb-2"><%= catNameById2.containsKey(p.getCategory_id()) ? catNameById2.get(p.getCategory_id()) : "Unknown" %></a>
                          <a href="#" class="d-block h4"><%= p.getName() %></a>
                          <del class="me-2 fs-5"><%= df2.format(p.getPrice() * 1000) %>đ</del>
                          <% if (p.getPrice_old() > 0) { %>
                          <span class="text-primary fs-5"><%= df2.format(p.getPrice_old() * 1000) %> đ</span>
                          <% } %>
                        </div>
                      </div>
                    </div>
                    <div class="products-mini-add border p-3">
                      <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i
                          class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                      <div class="d-flex">
                        <a href="#"
                           class="text-primary d-flex align-items-center justify-content-center me-3"><span
                            class="rounded-circle btn-sm-square border"><i
                              class="fas fa-random"></i></i></a>
                        <a href="#"
                           class="text-primary d-flex align-items-center justify-content-center me-0"><span
                            class="rounded-circle btn-sm-square border"><i class="fas fa-heart"></i></a>
                      </div>
                    </div>
                  </div>
                  <%
                      }
                    } else {
                  %>
                    <div class="text-center w-100"><p>Không có sản phẩm nào.</p></div>
                  <%
                    }
                  %>
                </div>
              </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Product List End -->

    <!-- Bestseller Products Start -->
    <div class="container-fluid products pb-5">
        <div class="container products-mini py-5">
            <div class="mx-auto text-center mb-5" style="max-width: 700px;">
                <h4 class="text-primary mb-4 border-bottom border-primary border-2 d-inline-block p-2 title-border-radius wow fadeInUp"
                    data-wow-delay="0.1s">Sản phẩm bán chạy nhất</h4>
            </div>
            <div class="row g-4">
                <%
                  java.util.List<an.dev.data.model.Product> randomProducts =
                    (java.util.List<an.dev.data.model.Product>) request.getAttribute("randomProducts");
                  if (randomProducts == null || randomProducts.isEmpty()) {
                    java.util.List<an.dev.data.model.Product> fallbackAll =
                      (java.util.List<an.dev.data.model.Product>) request.getAttribute("productList");
                    if (fallbackAll != null && !fallbackAll.isEmpty()) {
                      java.util.List<an.dev.data.model.Product> tmp = new java.util.ArrayList<>(fallbackAll);
                      int limit6 = Math.min(6, tmp.size());
                      randomProducts = tmp.subList(0, limit6);
                    }
                  }

                  java.util.List<an.dev.data.model.Category> catListBest =
                    (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                  java.util.Map<Integer, String> catNameByIdBest = new java.util.HashMap<>();
                  if (catListBest != null) {
                    for (an.dev.data.model.Category c : catListBest) {
                      catNameByIdBest.put(c.getId(), c.getName());
                    }
                  }

                  java.text.DecimalFormatSymbols symbolsBest = new java.text.DecimalFormatSymbols();
                  symbolsBest.setGroupingSeparator('.');
                  symbolsBest.setDecimalSeparator(',');
                  java.text.DecimalFormat dfBest = new java.text.DecimalFormat("#,##0.##", symbolsBest);

                  if (randomProducts != null && !randomProducts.isEmpty()) {
                    for (an.dev.data.model.Product rp : randomProducts) {
                %>
                <div class="col-md-6 col-lg-6 col-xl-4 wow fadeInUp" data-wow-delay="0.3s">
                  <div class="products-mini-item border">
                    <div class="row g-0">
                      <div class="col-5">
                        <div class="products-mini-img border-end h-100">
                          <img src="${pageContext.request.contextPath}/img/<%= rp.getImage() %>" class="img-fluid w-100 h-100" alt="<%= rp.getName() %>">
                          <div class="products-mini-icon rounded-circle bg-primary">
                            <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                          </div>
                        </div>
                      </div>
                      <div class="col-7">
                        <div class="products-mini-content p-3">
                          <a href="#" class="d-block mb-2"><%= catNameByIdBest.containsKey(rp.getCategory_id()) ? catNameByIdBest.get(rp.getCategory_id()) : "Unknown" %></a>
                          <a href="#" class="d-block h4"><%= rp.getName() %></a>
                          <del class="me-2 fs-5"><%= dfBest.format(rp.getPrice() * 1000) %>đ</del>
                          <% if (rp.getPrice_old() > 0) { %>
                          <span class="text-primary fs-5"><%= dfBest.format(rp.getPrice_old() * 1000) %> đ</span>
                          <% } %>
                        </div>
                      </div>
                    </div>
                    <div class="products-mini-add border p-3">
                      <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i class="fas fa-shopping-cart me-2"></i> Add To Cart</a>
                      <div class="d-flex">
                        <a href="#" class="text-primary d-flex align-items-center justify-content-center me-3"><span class="rounded-circle btn-sm-square border"><i class="fas fa-random"></i></i></a>
                        <a href="#" class="text-primary d-flex align-items-center justify-content-center me-0"><span class="rounded-circle btn-sm-square border"><i class="fas fa-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <%
                    }
                  } else {
                %>
                  <div class="text-center w-100"><p>Không có sản phẩm nào.</p></div>
                <%
                  }
                %>
            </div>
        </div>
    </div>
    <!-- Bestseller Products End -->


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
    <script src="${pageContext.request.contextPath}/lib/wow/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>


    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>