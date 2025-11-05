<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="./inc/header.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="alert alert-success shadow-sm" role="alert">
                    <h4 class="alert-heading mb-3">Thanh toán thành công!</h4>
                    <p class="mb-2">Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là: <strong>${order.code}</strong></p>
                    <hr>
                    <p class="mb-0">Bạn có thể xem chi tiết đơn hàng trong trang Đơn mua.</p>
                </div>
                <div class="d-flex gap-2">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/OrdersServlet">Xem đơn mua</a>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/HomeServlet">Tiếp tục mua sắm</a>
                </div>
            </div>
        </div>
    </div>

    <%@include file='./inc/footer.jsp' %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
