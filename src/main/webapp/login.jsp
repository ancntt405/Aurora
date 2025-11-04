<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Đăng nhập - AURORA</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="./inc/header.jsp" />
<div class="container py-5" style="min-height:60vh">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <h2 class="mb-4 text-center">Đăng nhập</h2>
            <%
                String errorMsg = (String) session.getAttribute("errors");
                String successMsg = (String) session.getAttribute("success");
                if (errorMsg != null && !errorMsg.isEmpty()) {
            %>
            <div class="alert alert-danger"><%= errorMsg %></div>
            <%
                session.removeAttribute("errors");
                }
                if (successMsg != null && !successMsg.isEmpty()) {
            %>
            <div class="alert alert-success"><%= successMsg %></div>
            <%
                session.removeAttribute("success");
                }
            %>
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="border rounded p-4 bg-white shadow-sm">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="login-password" name="password" placeholder="********" required>
                        <button class="btn btn-outline-secondary" type="button" id="toggle-login-password"><i class="bi bi-eye"></i></button>
                    </div>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary rounded-pill py-2">Đăng nhập</button>
                </div>
                <div class="mt-3 text-center">
                    <span>Chưa có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/RegisterServlet" class="text-primary">Đăng ký</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="./inc/footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
  (function(){
    var btn = document.getElementById('toggle-login-password');
    var input = document.getElementById('login-password');
    if(btn && input){
      btn.addEventListener('click', function(){
        var isPwd = input.getAttribute('type') === 'password';
        input.setAttribute('type', isPwd ? 'text' : 'password');
        var i = btn.querySelector('i');
        if(i){ i.className = isPwd ? 'bi bi-eye-slash' : 'bi bi-eye'; }
      });
    }
  })();
</script>
</body>
</html>
