<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Electro - Electronics Website Template</title>
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
</head>

<body>


   <jsp:include page="./inc/header.jsp" />

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
                                           <a href="<%= request.getContextPath() %>/HomeServlet?categoryId=<%= cat.getId() %>"><%= cat.getName() %></a>
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
                                                   <a href="<%= request.getContextPath() %>/HomeServlet?categoryId=<%= cat.getId() %>"><%= cat.getName() %></a>
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


    <!-- Shop Page Start -->
    <div class="container-fluid shop py-5">
        <div class="container py-5">
            <div class="row g-4">
                <div class="col-lg-3 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="product-categories mb-4">
                        <h4>Danh mục sản phẩm</h4>
                        <ul class="list-unstyled">
                          <%
                          java.util.List<an.dev.data.model.Category> categoryListLeft =
                          (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                          int printedLeft = 0;
                          if (categoryListLeft != null) {
                         for (an.dev.data.model.Category cat : categoryListLeft) {
                             if (printedLeft >= 10) break; // lấy 10 danh mục
                         %>
                            <li>
                                <div class="categories-item">
                                    <a href="<%= request.getContextPath() %>/HomeServlet?categoryId=<%= cat.getId() %>" class="text-dark"><i class="fas fa-apple-alt text-secondary me-2"></i><%= cat.getName() %></a>
                                </div>
                            </li>

                         <%
                            printedLeft++;
                            }
                          }
                          %>
                        </ul>
                    </div>
                   <form method="get" action="<%= request.getContextPath() %>/ShopServlet" class="mb-4">
                     <h4 class="mb-2">Price</h4>
                     <input type="range" class="form-range w-100" id="rangeInput" name="priceMax" min="0" max="500"
                            value="<%= request.getAttribute("priceMax") != null ? request.getAttribute("priceMax") : 0 %>"
                            oninput="document.getElementById('amountVnd').textContent = new Intl.NumberFormat('vi-VN').format(this.value*1000) + ' đ'">
                     <%
                       Object pmObj = request.getAttribute("priceMax");
                       double pmVal = 0;
                       try { if (pmObj != null) pmVal = Double.parseDouble(pmObj.toString()); } catch (Exception ignore) {}
                       java.text.DecimalFormatSymbols symVF = new java.text.DecimalFormatSymbols();
                       symVF.setGroupingSeparator('.');
                       symVF.setDecimalSeparator(',');
                       java.text.DecimalFormat dfVF = new java.text.DecimalFormat("#,##0", symVF);
                       String initialVnd = dfVF.format(pmVal * 1000) + " đ";
                     %>
                     <span id="amountVnd"><%= initialVnd %></span>
                     <button type="submit" class="btn btn-primary btn-sm mt-2">Lọc</button>
                   </form>

                    <div class="featured-product mb-4">
                      <h4 class="mb-3">Sản phẩm nổi bật</h4>
                      <%
                        java.util.List<an.dev.data.model.Product> featured =
                          (java.util.List<an.dev.data.model.Product>) request.getAttribute("featuredList");
                        java.text.DecimalFormatSymbols symF = new java.text.DecimalFormatSymbols();
                        symF.setGroupingSeparator('.');
                        symF.setDecimalSeparator(',');
                        java.text.DecimalFormat dfF = new java.text.DecimalFormat("#,##0.##", symF);
                        if (featured != null) {
                          for (an.dev.data.model.Product f : featured) {
                      %>
                      <div class="featured-product-item d-flex align-items-center">
                        <div class="rounded me-4" style="width: 100px; height: 100px;">
                          <%
                            String fImg = f.getImage();
                            String fSrc;
                            if (fImg != null && fImg.startsWith("http")) fSrc = fImg;
                            else if (fImg != null && (fImg.startsWith("img/") || fImg.startsWith("assets/"))) fSrc = request.getContextPath()+"/"+fImg;
                            else fSrc = request.getContextPath()+"/img/"+fImg;
                          %>
                          <img src="<%= fSrc %>" onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/img/product-1.png';" class="img-fluid rounded" alt="<%= f.getName() %>">
                        </div>
                        <div>
                          <h6 class="mb-2"><%= f.getName() %></h6>
                          <div class="d-flex mb-2">
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star"></i>
                          </div>
                          <div class="d-flex mb-2">
                            <h5 class="fw-bold me-2"><%= dfF.format(f.getPrice() * 1000) %> đ</h5>
                            <% if (f.getPrice_old() > 0) { %>
                              <h5 class="text-danger text-decoration-line-through"><%= dfF.format(f.getPrice_old() * 1000) %> đ</h5>
                            <% } %>
                          </div>
                        </div>
                      </div>
                      <%
                          }
                        }
                      %>
                    </div>

                    
                </div>
                <div class="col-lg-9 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="rounded mb-4">
                        <div class="owl-carousel banner-carousel">
                        <%
                        java.util.List<an.dev.data.model.Banner> bannerList =
                        (java.util.List<an.dev.data.model.Banner>) request.getAttribute("bannerList");
                         int count = 0;
                         if (bannerList != null) {
                         for (an.dev.data.model.Banner banner : bannerList) {
                         if (count >= 3) break;
                         %>
                            <div class="position-relative">
                                <img src="${pageContext.request.contextPath}/img/<%= banner.getImage() %>" class="img-fluid rounded w-100" style="height: 250px;" alt="<%= banner.getTitle() %>">

                            </div>
                         <%
                            count++;
                           }
                           }
                         %>
                        </div>
                    </div>
                    <div class="row g-4">
                        <div class="col-xl-7">
                            <div class="input-group w-100 mx-auto d-flex">
                                <input type="search" class="form-control p-3" placeholder="Tìm kiếm"
                                    aria-describedby="search-icon-1">
                                <span id="search-icon-1" class="input-group-text p-3"><i
                                        class="fa fa-search"></i></span>
                            </div>
                        </div>
                        <div class="col-xl-3 text-end">
                            <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between">
                                <label for="sortSelect" class="me-2">Sắp xếp theo</label>
                                <form id="sortForm" method="get" action="<%= request.getContextPath() %>/ShopServlet" class="m-0">
                                  <%
                                    String currentSort = (String) request.getAttribute("sort");
                                    String catKeep = request.getParameter("categoryId");
                                    Object pmKeepObj = request.getAttribute("priceMax");
                                    String pmKeep = pmKeepObj != null ? pmKeepObj.toString() : request.getParameter("priceMax");
                                  %>
                                  <% if (catKeep != null && !catKeep.isEmpty()) { %>
                                    <input type="hidden" name="categoryId" value="<%= catKeep %>">
                                  <% } %>
                                  <% if (pmKeep != null && !pmKeep.isEmpty()) { %>
                                    <input type="hidden" name="priceMax" value="<%= pmKeep %>">
                                  <% } %>
                                  <select id="sortSelect" name="sort" class="border-0 form-select-sm bg-light me-3" onchange="document.getElementById('sortForm').submit()">
                                    <option value="" <%= (currentSort == null || currentSort.isEmpty()) ? "selected" : "" %>>Mặc định</option>
                                    <option value="price_asc" <%= "price_asc".equals(currentSort) ? "selected" : "" %>>Giá tăng dần</option>
                                    <option value="price_desc" <%= "price_desc".equals(currentSort) ? "selected" : "" %>>Giá giảm dần</option>
                                    <option value="name_asc" <%= "name_asc".equals(currentSort) ? "selected" : "" %>>Tên A→Z</option>
                                    <option value="newest" <%= "newest".equals(currentSort) ? "selected" : "" %>>Mới nhất</option>
                                  </select>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-4 col-xl-2">
                            <ul class="nav nav-pills d-inline-flex text-center py-2 px-2 rounded bg-light mb-4">
                                <li class="nav-item me-4">
                                    <a class="bg-light" data-bs-toggle="pill" href="#tab-5">
                                        <i class="fas fa-th fa-3x text-primary"></i>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="bg-light" data-bs-toggle="pill" href="#tab-6">
                                        <i class="fas fa-bars fa-3x text-primary"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div id="tab-5" class="tab-pane fade show p-0 active">
                            <div class="row g-4">
                                <%
                                  java.util.List<an.dev.data.model.Product> products =
                                      (java.util.List<an.dev.data.model.Product>) request.getAttribute("productList");
                                  java.util.List<an.dev.data.model.Category> categories =
                                      (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                                  java.util.Map<Integer, String> catNameById = new java.util.HashMap<>();
                                  if (categories != null) {
                                    for (an.dev.data.model.Category c : categories) {
                                      catNameById.put(c.getId(), c.getName());
                                    }
                                  }
                                  java.text.DecimalFormatSymbols sym = new java.text.DecimalFormatSymbols();
                                  sym.setGroupingSeparator('.');
                                  sym.setDecimalSeparator(',');
                                  java.text.DecimalFormat df = new java.text.DecimalFormat("#,##0.##", sym);
                                  if (products != null && !products.isEmpty()) {
                                    for (an.dev.data.model.Product p : products) {
                                %>
                                <div class="col-md-6 col-lg-4 col-xl-3">
                                    <div class="product-item rounded wow fadeInUp" data-wow-delay="0.1s">
                                        <div class="product-item-inner border rounded">
                                            <div class="product-item-inner-item">
                                                <%
                                                  String imgVal = p.getImage();
                                                  String imgSrc;
                                                  if (imgVal != null && imgVal.startsWith("http")) imgSrc = imgVal;
                                                  else if (imgVal != null && (imgVal.startsWith("img/") || imgVal.startsWith("assets/"))) imgSrc = request.getContextPath()+"/"+imgVal;
                                                  else imgSrc = request.getContextPath()+"/img/"+imgVal;
                                                %>
                                                <img src="<%= imgSrc %>" onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/img/product-1.png';" class="img-fluid w-100 rounded-top" alt="<%= p.getName() %>">
                                                <div class="product-details">
                                                    <a href="#"><i class="fa fa-eye fa-1x"></i></a>
                                                </div>
                                            </div>
                                            <div class="text-center rounded-bottom p-4">
                                                <a href="#" class="d-block mb-2"><%= p.getName() %></a>
                                                <a href="#" class="d-block h4"><%= catNameById.getOrDefault(p.getCategory_id(), "Unknown") %></a>
                                                <del class="me-2 fs-5"><%= df.format(p.getPrice() * 1000) %>đ</del>
                                                <% if (p.getPrice_old() > 0) { %>
                                                  <span class="text-primary fs-5"><%= df.format(p.getPrice_old() * 1000) %> đ</span>
                                                <% } %>
                                            </div>
                                        </div>
                                        <div class="product-item-add border border-top-0 rounded-bottom  text-center p-4 pt-0">
                                            <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4 mb-4"><i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ hàng</a>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="d-flex">
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star text-primary"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                                <div class="d-flex">
                                                    <a href="#" class="text-primary d-flex align-items-center justify-content-center me-3"><span class="rounded-circle btn-sm-square border"><i class="fas fa-random"></i></span></a>
                                                    <a href="#" class="text-primary d-flex align-items-center justify-content-center me-0"><span class="rounded-circle btn-sm-square border"><i class="fas fa-heart"></i></span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                  } else {
                                %>
                                  <div class="col-12 text-center"><p>Không có sản phẩm nào.</p></div>
                                <%
                                  }
                                %>
                            </div>
                            <div class="row g-4 product">
                                <div class="col-12 wow fadeInUp" data-wow-delay="0.1s">
                                      <div class="pagination d-flex justify-content-center mt-5">
                                                                      <%
                                                                        Integer curPageObj = (Integer) request.getAttribute("page");
                                                                        Integer totalPageObj = (Integer) request.getAttribute("numberPage");
                                                                        int curPage = (curPageObj != null) ? curPageObj : 1;
                                                                        int totalPages = (totalPageObj != null && totalPageObj > 0) ? totalPageObj : 1;
                                                                        String keepCat = request.getParameter("categoryId");
                                                                        Object keepPriceObj = request.getAttribute("priceMax");
                                                                        String keepPrice = keepPriceObj != null ? keepPriceObj.toString() : request.getParameter("priceMax");
                                                                        String keepSort = (String) request.getAttribute("sort");
                                                                        String base = request.getContextPath() + "/ShopServlet";
                                                                        String extra = "";
                                                                        if (keepCat != null && !keepCat.isEmpty()) extra += "&categoryId=" + keepCat;
                                                                        if (keepPrice != null && !keepPrice.isEmpty()) extra += "&priceMax=" + keepPrice;
                                                                        if (keepSort != null && !keepSort.isEmpty()) extra += "&sort=" + keepSort;
                                                                        String mk = extra.isEmpty() ? "?page=" : "?page="; // always ?page first
                                                                      %>
                                                                      <a class="rounded <%= (curPage<=1) ? "disabled" : "" %>" href="<%= base + mk + (curPage-1) + extra %>">&laquo;</a>
                                                                      <%
                                                                        for (int i = 1; i <= totalPages; i++) {
                                                                      %>
                                                                        <a class="rounded <%= (i==curPage) ? "active" : "" %>" href="<%= base + mk + i + extra %>"><%= i %></a>
                                                                      <%
                                                                        }
                                                                      %>
                                                                      <a class="rounded <%= (curPage>=totalPages) ? "disabled" : "" %>" href="<%= base + mk + (curPage+1) + extra %>">&raquo;</a>
                                                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tab-6" class="products tab-pane fade show p-0">
                            <div class="row g-4 products-mini">
                              <%
                                java.util.List<an.dev.data.model.Product> productsMini =
                                  (java.util.List<an.dev.data.model.Product>) request.getAttribute("productList");
                                java.util.List<an.dev.data.model.Category> categoriesMini =
                                  (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                                java.util.Map<Integer, String> catNameByIdMini = new java.util.HashMap<>();
                                if (categoriesMini != null) {
                                  for (an.dev.data.model.Category c : categoriesMini) {
                                    catNameByIdMini.put(c.getId(), c.getName());
                                  }
                                }
                                java.text.DecimalFormatSymbols symM = new java.text.DecimalFormatSymbols();
                                symM.setGroupingSeparator('.');
                                symM.setDecimalSeparator(',');
                                java.text.DecimalFormat dfM = new java.text.DecimalFormat("#,##0.##", symM);
                                if (productsMini != null && !productsMini.isEmpty()) {
                                  for (an.dev.data.model.Product p : productsMini) {
                              %>
                                <div class="col-lg-6">
                                    <div class="products-mini-item border">
                                        <div class="row g-0">
                                            <div class="col-5">
                                                <div class="products-mini-img border-end h-100">
                                                    <%
                                                      String mImgVal = p.getImage();
                                                      String mImgSrc;
                                                      if (mImgVal != null && mImgVal.startsWith("http")) mImgSrc = mImgVal;
                                                      else if (mImgVal != null && (mImgVal.startsWith("img/") || mImgVal.startsWith("assets/"))) mImgSrc = request.getContextPath()+"/"+mImgVal;
                                                      else mImgSrc = request.getContextPath()+"/img/"+mImgVal;
                                                    %>
                                                    <img src="<%= mImgSrc %>" onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/img/product-1.png';" class="img-fluid w-100 h-100" alt="<%= p.getName() %>">
                                                    <div class="products-mini-icon rounded-circle bg-primary">
                                                        <a href="#"><i class="fa fa-eye fa-1x text-white"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-7">
                                                <div class="products-mini-content p-3">
                                                    <a href="#" class="d-block mb-2"><%= catNameByIdMini.getOrDefault(p.getCategory_id(), "Unknown") %></a>
                                                    <a href="#" class="d-block h4"><%= p.getName() %></a>
                                                    <del class="me-2 fs-5"><%= dfM.format(p.getPrice() * 1000) %>đ</del>
                                                    <% if (p.getPrice_old() > 0) { %>
                                                      <span class="text-primary fs-5"><%= dfM.format(p.getPrice_old() * 1000) %> đ</span>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="products-mini-add border p-3">
                                            <a href="#" class="btn btn-primary border-secondary rounded-pill py-2 px-4"><i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ hàng</a>
                                            <div class="d-flex">
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-3"><span class="rounded-circle btn-sm-square border"><i class="fas fa-random"></i></span></a>
                                                <a href="#" class="text-primary d-flex align-items-center justify-content-center me-0"><span class="rounded-circle btn-sm-square border"><i class="fas fa-heart"></i></span></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                              <%
                                  }
                                } else {
                              %>
                                <div class="col-12 text-center"><p>Không có sản phẩm nào.</p></div>
                              <%
                                }
                              %>
                              <div class="col-12 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="pagination d-flex justify-content-center mt-5">
                                  <%
                                    Integer curPageObj2 = (Integer) request.getAttribute("page");
                                    Integer totalPageObj2 = (Integer) request.getAttribute("numberPage");
                                    int curPage2 = (curPageObj2 != null) ? curPageObj2 : 1;
                                    int totalPages2 = (totalPageObj2 != null && totalPageObj2 > 0) ? totalPageObj2 : 1;
                                    String keepCat2 = request.getParameter("categoryId");
                                    Object keepPriceObj2 = request.getAttribute("priceMax");
                                    String keepPrice2 = keepPriceObj2 != null ? keepPriceObj2.toString() : request.getParameter("priceMax");
                                    String keepSort2 = (String) request.getAttribute("sort");
                                    String base2 = request.getContextPath() + "/ShopServlet";
                                    String extra2 = "";
                                    if (keepCat2 != null && !keepCat2.isEmpty()) extra2 += "&categoryId=" + keepCat2;
                                    if (keepPrice2 != null && !keepPrice2.isEmpty()) extra2 += "&priceMax=" + keepPrice2;
                                    if (keepSort2 != null && !keepSort2.isEmpty()) extra2 += "&sort=" + keepSort2;
                                    String mk2 = "?page="; // always ?page first
                                  %>
                                  <a class="rounded <%= (curPage2<=1) ? "disabled" : "" %>" href="<%= base2 + mk2 + (curPage2-1) + extra2 %>">&laquo;</a>
                                  <%
                                    for (int i = 1; i <= totalPages2; i++) {
                                  %>
                                    <a class="rounded <%= (i==curPage2) ? "active" : "" %>" href="<%= base2 + mk2 + i + extra2 %>"><%= i %></a>
                                  <%
                                    }
                                  %>
                                  <a class="rounded <%= (curPage2>=totalPages2) ? "disabled" : "" %>" href="<%= base2 + mk2 + (curPage2+1) + extra2 %>">&raquo;</a>
                                </div>
                              </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Shop Page End -->

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
    <script>
      (function(){
        if (window.jQuery) {
          $(function(){
            var $el = $('.banner-carousel');
            if ($el.length && !$el.hasClass('owl-loaded')) {
              $el.owlCarousel({
                items: 1,
                loop: true,
                autoplay: true,
                autoplayTimeout: 3000,
                autoplayHoverPause: true,
                dots: true,
                nav: false,
                smartSpeed: 600
              });
            }
          });
        }
      })();
    </script>
</body>

</html>