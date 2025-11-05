<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Topbar Start -->
    <div class="container-fluid px-5 d-none border-bottom d-lg-block">
        <div class="row gx-0 align-items-center">
            <div class="col-lg-4 text-center text-lg-start mb-lg-0">
                <div class="d-inline-flex align-items-center" style="height: 45px;">
                    <a href="${pageContext.request.contextPath}/AboutServlet" class="text-muted mx-2"> Hỗ trợ</a><small> / </small>
                    <a href="${pageContext.request.contextPath}/ContactServlet" class="text-muted ms-2"> Liên Hệ</a>

                </div>
            </div>
            <div class="col-lg-4 text-center d-flex align-items-center justify-content-center">
                <small class="text-dark">Liên Hệ:</small>
                <a href="#" class="text-muted">(+0) 1234 567890</a>
            </div>

            <div class="col-lg-4 text-center text-lg-end">
                <div class="d-inline-flex align-items-center" style="height: 45px;">
                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle text-muted mx-2" data-bs-toggle="dropdown"><small>
                                Vietnamese</small></a>
                        <div class="dropdown-menu rounded">
                            <a href="#" class="dropdown-item"> Vietnamese</a>
                            <a href="#" class="dropdown-item"> English</a>
                        </div>
                    </div>
                    <div class="dropdown">
                        <%
                          an.dev.data.model.User currentUser = (an.dev.data.model.User) session.getAttribute("user");
                          boolean isAdmin = (currentUser != null && "admin".equals(currentUser.getRole()));
                          String displayName = (currentUser != null && currentUser.getName() != null && !currentUser.getName().trim().isEmpty())
                                  ? currentUser.getName() : (currentUser != null ? currentUser.getEmail() : null);
                        %>
                        <a href="#" class="dropdown-toggle text-muted ms-2" data-bs-toggle="dropdown"><small>
                            <i class="fa fa-user me-2"></i>
                            <%= (displayName != null) ? displayName : "Tài khoản" %>
                        </small></a>
                        <div class="dropdown-menu rounded">
                          <%
                            if (currentUser == null) {
                          %>
                            <a href="${pageContext.request.contextPath}/LoginServlet" class="dropdown-item">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/RegisterServlet" class="dropdown-item">Đăng ký</a>
                          <%
                            } else {
                          %>
                            <span class="dropdown-item-text"><strong><%= displayName %></strong></span>
                            <span class="dropdown-item-text text-muted"><%= currentUser.getEmail() %></span>
                            <div class="dropdown-divider"></div>
                            <a href="#" class="dropdown-item">Danh sách yêu thích</a>
                            <a href="${pageContext.request.contextPath}/CartServlet" class="dropdown-item">Giỏ hàng của tôi</a>
                            <a href="${pageContext.request.contextPath}/UserServlet" class="dropdown-item">Cài đặt tài khoản</a>
                            <a href="${pageContext.request.contextPath}/ProfileServlet" class="dropdown-item">Tài khoản của tôi</a>
                            <%
                              if (isAdmin) {
                            %>
                              <a href="${pageContext.request.contextPath}/DashboardServlet" class="dropdown-item">Trang quản trị</a>
                            <%
                              }
                            %>
                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/LogoutServlet" class="dropdown-item">Đăng xuất</a>
                          <%
                            }
                          %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid px-5 py-4 d-none d-lg-block">
        <div class="row gx-0 align-items-center text-center">
            <div class="col-md-4 col-lg-3 text-center text-lg-start">
                <div class="d-inline-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/HomeServlet" class="navbar-brand p-0">
                        <h1 class="display-5 text-primary m-0"><i
                                class="fas fa-shopping-bag text-secondary me-2"></i>AURORA</h1>
                        <!-- <img src="img/logo.png" alt="Logo"> -->
                    </a>
                </div>
            </div>
            <div class="col-md-4 col-lg-6 text-center">
                <div class="position-relative ps-4">
                    <form class="d-flex border rounded-pill w-100" method="get" action="${pageContext.request.contextPath}/SearchServlet">
                        <input class="form-control border-0 rounded-pill w-100 py-3" type="search" name="q"
                               placeholder="Bạn cần tìm kiếm gì trong hôm nay?" value="${param.q}">
                        <select class="form-select text-dark border-0 border-start rounded-0 p-3" name="categoryId" style="width: 200px;">
                            <option value="">Tất cả danh mục</option>
                              <%
                              java.util.List<an.dev.data.model.Category> categoryList =
                              (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                               int printed = 0;
                               if (categoryList != null) {
                               for (an.dev.data.model.Category cat : categoryList) {
                                  if (printed >= 10) break; // lấy 10 danh mục
                               %>
                            <option value="<%= cat.id %>" <%= String.valueOf(cat.id).equals(request.getParameter("categoryId")) ? "selected" : "" %>><%= cat.name %></option>
                             <%
                                printed++;
                                }
                                }
                              %>
                        </select>
                        <button type="submit" class="btn btn-primary rounded-pill py-3 px-5" style="border: 0;">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
            <div class="col-md-4 col-lg-3 text-center text-lg-end">
                <div class="d-inline-flex align-items-center">
                    <a href="#" class="text-muted d-flex align-items-center justify-content-center me-3"><span
                            class="rounded-circle btn-md-square border"><i class="fas fa-heart"></i></span></a>
                    <a href="${pageContext.request.contextPath}/CartServlet" class="text-muted d-flex align-items-center justify-content-center position-relative">
                        <span class="rounded-circle btn-md-square border position-relative">
                            <i class="fas fa-shopping-cart"></i>
                            <c:set var="cartQty" value="${sessionScope.totalQuantity}" />
                            <c:if test="${cartQty > 0}">
                              <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 10px;">
                                ${cartQty}
                              </span>
                            </c:if>
                        </span>
                        <span class="text-dark ms-2">Giỏ hàng</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->