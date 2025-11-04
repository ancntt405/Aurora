<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="an.dev.data.model.User" %>
<%
    String ctx = request.getContextPath();
    User user = (User) request.getAttribute("user");
    String idParam = request.getParameter("id");
    Integer id = null;
    if (user != null) {
        id = user.getId();
    } else if (idParam != null) {
        try { id = Integer.parseInt(idParam); } catch (Exception ignore) {}
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa người dùng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="<%=ctx%>/css/style.css" />
    <link rel="stylesheet" href="<%=ctx%>/css/admin.css" />
</head>
<body>
<div class="container">
    <h1>Chỉnh sửa người dùng</h1>
    <p><a href="<%=ctx%>/IndexUserServlet">Danh sách</a> | <a href="<%=ctx%>/DashboardServlet">Dashboard</a></p>

    <form method="post" action="<%=ctx%>/EditUserServlet">
        <input type="hidden" name="id" value="<%= id != null ? id : 0 %>" />
        <div>
            <label>Họ tên</label>
            <input type="text" name="name" value="<%= user != null ? user.getName() : "" %>" required />
        </div>
        <div>
            <label>Email</label>
            <input type="email" name="email" value="<%= user != null ? user.getEmail() : "" %>" required />
        </div>
        <div>
            <label>Số điện thoại</label>
            <input type="text" name="phone" value="<%= user != null ? user.getPhone() : "" %>" />
        </div>
        <div>
            <label>Mật khẩu (để trống nếu không đổi)</label>
            <input type="password" name="password" />
        </div>
        <div>
            <label>Quyền</label>
            <select name="role">
                <option value="user" <%= (user != null && "user".equals(user.getRole())) ? "selected" : "" %>>user</option>
                <option value="admin" <%= (user != null && "admin".equals(user.getRole())) ? "selected" : "" %>>admin</option>
            </select>
        </div>
        <div>
            <button type="submit">Lưu</button>
        </div>
    </form>
</div>
<script src="<%=ctx%>/js/admin.js"></script>
</body>
</html>
