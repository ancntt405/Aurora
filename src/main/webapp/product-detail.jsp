<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <title>Chi tiết sản phẩm</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Icon Font Stylesheet -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

  <!-- Site Styles -->
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
  <style>
    .pd-images { gap: 12px; }
    .pd-thumb { width: 80px; height: 80px; object-fit: cover; border-radius: 6px; border: 1px solid #eee; cursor: pointer; }
    .pd-main { width: 100%; max-height: 480px; object-fit: cover; border-radius: 8px; border: 1px solid #eee; }
    .pd-meta small { display: inline-block; margin-right: 12px; color: #6c757d; }
    .pd-thumb.active { outline: 2px solid #0d6efd; }
    .badge-discount { background: #dc3545; color: #fff; border-radius: 999px; padding: 4px 10px; font-weight: 600; }
  </style>
</head>
<body>
  <jsp:include page="./inc/header.jsp" />

  <div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">Chi tiết sản phẩm</h1>
    <ol class="breadcrumb justify-content-center mb-0">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeServlet">Trang chủ</a></li>
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/ShopServlet">Cửa hàng</a></li>
      <li class="breadcrumb-item active text-white">Chi tiết</li>
    </ol>
  </div>

  <div class="container py-5">
    <c:choose>
      <c:when test="${empty product}">
        <div class="alert alert-warning">Không tìm thấy sản phẩm.</div>
      </c:when>
      <c:otherwise>
        <div class="row g-4">
          <div class="col-lg-6">
            <c:set var="imgVal" value="${product.image}"/>
            <c:set var="imgSrc" value=""/>
            <c:choose>
              <c:when test="${not empty imgVal and fn:startsWith(imgVal, 'http')}">
                <c:set var="imgSrc" value="${imgVal}"/>
              </c:when>
              <c:when test="${not empty imgVal and (fn:startsWith(imgVal, 'img/') or fn:startsWith(imgVal, 'assets/'))}">
                <c:set var="imgSrc" value="${pageContext.request.contextPath}/${imgVal}"/>
              </c:when>
              <c:otherwise>
                <c:set var="imgSrc" value="${pageContext.request.contextPath}/img/${imgVal}"/>
              </c:otherwise>
            </c:choose>
            <img id="pdMain" class="pd-main w-100" src="${imgSrc}" alt="${product.name}">

            <c:if test="${not empty galleries}">
              <div class="d-flex pd-images mt-3 flex-wrap">
                <c:forEach items="${galleries}" var="photo">
                  <img class="pd-thumb" src="${photo.image_url}" alt="${product.name}"
                       onerror="this.style.display='none'"
                       onclick="document.getElementById('pdMain').src=this.src;">
                </c:forEach>
              </div>
            </c:if>
          </div>

          <div class="col-lg-6">
            <h3 class="mb-2">${product.name}</h3>
            <div class="pd-meta mb-2">
              <small>Mã: #${product.id}</small>
              <small>
                Danh mục:
                <%
                  java.util.List<an.dev.data.model.Category> _cats = (java.util.List<an.dev.data.model.Category>) request.getAttribute("categoryList");
                  an.dev.data.model.Product _pInfo = (an.dev.data.model.Product) request.getAttribute("product");
                  String _catName = null;
                  if (_cats != null && _pInfo != null) {
                    for (an.dev.data.model.Category _c : _cats) {
                      if (_c.getId() == _pInfo.getCategory_id()) { _catName = _c.getName(); break; }
                    }
                  }
                %>
                <%= (_catName != null && !_catName.isEmpty()) ? _catName : String.valueOf(((an.dev.data.model.Product)request.getAttribute("product")).getCategory_id()) %>
              </small>
              <small>Trạng thái: <span class="${product.status ? 'text-success' : 'text-muted'}">${product.status ? 'Còn bán' : 'Ẩn'}</span></small>
            </div>
            <div class="mb-3">
              <span class="h4 text-primary fw-bold"><fmt:formatNumber value="${product.price * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
              <c:if test="${product.price_old > 0}">
                <del class="ms-2 text-muted"><fmt:formatNumber value="${product.price_old * 1000}" type="currency" currencySymbol="₫" groupingUsed="true"/></del>
                <%
                  an.dev.data.model.Product _p = (an.dev.data.model.Product) request.getAttribute("product");
                  double _pr = _p != null ? _p.getPrice() : 0.0;
                  double _old = _p != null ? _p.getPrice_old() : 0.0;
                  int _disc = (_old > 0 && _old > _pr) ? (int) Math.round((1 - _pr/_old) * 100) : 0;
                %>
                <c:if test="<%= (_disc > 0) %>"><span class="badge-discount ms-2">-<%= _disc %>%</span></c:if>
              </c:if>
            </div>
            <div class="mb-4">
              <h6>Mô tả</h6>
              <p class="mb-0">${product.description}</p>
            </div>
            <form class="d-flex align-items-center gap-3" method="post" action="${pageContext.request.contextPath}/CartServlet">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="${product.id}">
              <input type="hidden" name="price" value="${product.price}">
              <input type="hidden" name="redirect" value="back">
              <div class="input-group" style="width: 180px;">
                <button class="btn btn-outline-secondary" type="button" id="qtyMinus">−</button>
                <input id="qtyInput" name="quantity" type="number" class="form-control text-center" min="1" value="1">
                <button class="btn btn-outline-secondary" type="button" id="qtyPlus">+</button>
              </div>
              <button type="submit" class="btn btn-primary"><i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ hàng</button>
              <a href="${pageContext.request.contextPath}/ShopServlet" class="btn btn-outline-secondary">Quay lại cửa hàng</a>
            </form>
          </div>
        </div>

        <c:if test="${not empty relatedProducts}">
          <hr class="my-5">
          <h4 class="mb-3">Sản phẩm liên quan</h4>
          <div class="row g-3">
            <c:forEach items="${relatedProducts}" var="rp">
              <div class="col-6 col-md-3">
                <div class="border rounded p-2 h-100">
                  <c:set var="rImg" value="${rp.image}"/>
                  <c:set var="rSrc" value=""/>
                  <c:choose>
                    <c:when test="${not empty rImg and fn:startsWith(rImg, 'http')}"><c:set var="rSrc" value="${rImg}"/></c:when>
                    <c:when test="${not empty rImg and (fn:startsWith(rImg, 'img/') or fn:startsWith(rImg, 'assets/'))}"><c:set var="rSrc" value="${pageContext.request.contextPath}/${rImg}"/></c:when>
                    <c:otherwise><c:set var="rSrc" value="${pageContext.request.contextPath}/img/${rImg}"/></c:otherwise>
                  </c:choose>
                  <a href="${pageContext.request.contextPath}/DetailServlet?productId=${rp.id}">
                    <img class="img-fluid w-100 mb-2" style="height:160px; object-fit:cover;" src="${rSrc}" alt="${rp.name}">
                  </a>
                  <div class="small">${rp.name}</div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:if>
      </c:otherwise>
    </c:choose>
  </div>

  <jsp:include page="./inc/footer.jsp" />
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Quantity controls
    (function(){
      var minus = document.getElementById('qtyMinus');
      var plus = document.getElementById('qtyPlus');
      var input = document.getElementById('qtyInput');
      if (minus && plus && input) {
        minus.addEventListener('click', function(){
          var v = parseInt(input.value || '1', 10);
          if (isNaN(v) || v < 1) v = 1;
          v = Math.max(1, v - 1);
          input.value = v;
        });
        plus.addEventListener('click', function(){
          var v = parseInt(input.value || '1', 10);
          if (isNaN(v) || v < 1) v = 1;
          input.value = v + 1;
        });
      }

      // Gallery active highlight
      var main = document.getElementById('pdMain');
      var thumbs = document.querySelectorAll('.pd-thumb');
      function setActive(el){
        thumbs.forEach(function(t){ t.classList.remove('active'); });
        if (el) el.classList.add('active');
      }
      thumbs.forEach(function(t){
        t.addEventListener('click', function(){ setActive(t); if (main) main.src = t.src; });
      });
      if (thumbs.length > 0) setActive(thumbs[0]);
    })();
  </script>
</body>
</html>
