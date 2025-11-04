<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Đăng ký - AURORA</title>
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
        <div class="col-md-7 col-lg-6">
            <h2 class="mb-4 text-center">Tạo tài khoản</h2>
            <%
                String registerError = (String) session.getAttribute("errors");
                String registerSuccess = (String) session.getAttribute("success");
                if (registerError != null && !registerError.isEmpty()) {
            %>
            <div class="alert alert-danger"><%= registerError %></div>
            <%
                session.removeAttribute("errors");
                }
                if (registerSuccess != null && !registerSuccess.isEmpty()) {
            %>
            <div class="alert alert-success"><%= registerSuccess %></div>
            <%
                session.removeAttribute("success");
                }
            %>
            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="border rounded p-4 bg-white shadow-sm">
                <div class="mb-3">
                    <label for="name" class="form-label">Họ và tên</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Nguyễn Văn A" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="reg-password" name="password" placeholder="********" required>
                            <button class="btn btn-outline-secondary" type="button" id="toggle-reg-password"><i class="bi bi-eye"></i></button>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="confirm" class="form-label">Nhập lại mật khẩu</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="reg-confirm" name="confirm" placeholder="********" required>
                            <button class="btn btn-outline-secondary" type="button" id="toggle-reg-confirm"><i class="bi bi-eye"></i></button>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="phone" name="phone" placeholder="0123456789">
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary rounded-pill py-2">Đăng ký</button>
                </div>
                <div class="mt-3 text-center">
                    <span>Đã có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="text-primary">Đăng nhập</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="./inc/footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
  (function(){
    function bindToggle(btnId, inputId){
      var btn = document.getElementById(btnId);
      var input = document.getElementById(inputId);
      if(btn && input){
        btn.addEventListener('click', function(){
          var isPwd = input.getAttribute('type') === 'password';
          input.setAttribute('type', isPwd ? 'text' : 'password');
          var i = btn.querySelector('i');
          if(i){ i.className = isPwd ? 'bi bi-eye-slash' : 'bi bi-eye'; }
        });
      }
    }
    bindToggle('toggle-reg-password', 'reg-password');
    bindToggle('toggle-reg-confirm', 'reg-confirm');
  })();
</script>
</body>
</html>
