<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <title>Tìm kiếm sản phẩm</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="./inc/header.jsp" />

  <div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">Kết quả tìm kiếm</h1>
    <ol class="breadcrumb justify-content-center mb-0">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">Trang chủ</a></li>
      <li class="breadcrumb-item active text-white">Tìm kiếm</li>
    </ol>
  </div>

  <div class="container py-5">
    <form class="row g-2 mb-4" method="get" action="${pageContext.request.contextPath}/SearchServlet">
      <div class="col-md-8">
        <input type="search" class="form-control" name="q" placeholder="Nhập từ khóa" value="${fn:escapeXml(param.q)}">
      </div>
      <div class="col-md-2">
        <select class="form-select" name="categoryId">
          <option value="">Tất cả danh mục</option>
          <c:forEach items="${categoryList}" var="cat">
            <option value="${cat.id}" ${param.categoryId == (cat.id).toString() ? 'selected' : ''}>${cat.name}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-2">
        <button class="btn btn-primary w-100">Tìm kiếm</button>
      </div>
    </form>

    <c:set var="items" value="${empty productList ? productsList : productList}" />
    <p class="text-muted mb-3">Tìm thấy ${empty total ? fn:length(items) : total} sản phẩm cho "${fn:escapeXml(q)}"</p>

    <div class="row g-4">
      <c:choose>
        <c:when test="${empty items}">
          <div class="col-12 text-center"><em>Không có sản phẩm phù hợp.</em></div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${items}" var="p">
            <div class="col-sm-6 col-md-4 col-lg-3">
              <div class="product-item rounded">
                <div class="product-item-inner border rounded">
                  <div class="product-item-inner-item">
                    <c:set var="imgVal" value="${p.image}" />
                    <c:set var="imgSrc" value="" />
                    <c:choose>
                      <c:when test="${not empty imgVal and fn:startsWith(imgVal, 'http')}">
                        <c:set var="imgSrc" value="${imgVal}" />
                      </c:when>
                      <c:when test="${not empty imgVal and (fn:startsWith(imgVal, 'img/') or fn:startsWith(imgVal, 'assets/'))}">
                        <c:set var="imgSrc" value="${pageContext.request.contextPath}/${imgVal}" />
                      </c:when>
                      <c:otherwise>
                        <c:set var="imgSrc" value="${pageContext.request.contextPath}/img/${imgVal}" />
                      </c:otherwise>
                    </c:choose>
                    <img src="${imgSrc}" class="img-fluid w-100 rounded-top" style="height: 220px; object-fit: cover;" alt="${p.name}">
                  </div>
                  <div class="text-center rounded-bottom p-3">
                    <a href="#" class="d-block mb-1">${p.name}</a>
                    <div>
                      <span class="fw-bold text-primary"><fmt:formatNumber value="${p.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                      <c:if test="${p.price_old > 0}">
                        <small class="text-muted text-decoration-line-through ms-1"><fmt:formatNumber value="${p.price_old * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></small>
                      </c:if>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <c:if test="${numberPage > 1}">
      <div class="pagination d-flex justify-content-center mt-5">
        <c:set var="base" value="${pageContext.request.contextPath}/SearchServlet" />
        <c:set var="extra" value="" />
        <c:if test="${not empty q}"><c:set var="extra" value="${extra}&q=${fn:escapeXml(q)}"/></c:if>
        <c:if test="${not empty categoryId}"><c:set var="extra" value="${extra}&categoryId=${categoryId}"/></c:if>
        <a class="rounded ${page <= 1 ? 'disabled' : ''}" href="${base}?page=${page-1}${extra}">&laquo;</a>
        <c:forEach var="i" begin="1" end="${numberPage}">
          <a class="rounded ${i == page ? 'active' : ''}" href="${base}?page=${i}${extra}">${i}</a>
        </c:forEach>
        <a class="rounded ${page >= numberPage ? 'disabled' : ''}" href="${base}?page=${page+1}${extra}">&raquo;</a>
      </div>
    </c:if>
  </div>

  <jsp:include page="./inc/footer.jsp" />
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
