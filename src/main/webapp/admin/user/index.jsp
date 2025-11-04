<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="an.dev.data.model.User" %>
<%
    String ctx = request.getContextPath();
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách người dùng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="<%=ctx%>/css/style.css" />
    <link rel="stylesheet" href="<%=ctx%>/css/admin.css" />
</head>
<body>
<div class="container">
    <h1>Danh sách người dùng</h1>
    <p><a href="<%=ctx%>/CreateUserServlet">Tạo mới</a> | <a href="<%=ctx%>/DashboardServlet">Dashboard</a></p>

    <% if (users == null || users.isEmpty()) { %>
        <p>Chưa có dữ liệu. <a href="<%=ctx%>/IndexUserServlet">Tải lại</a></p>
    <% } else { %>
        <table border="1" cellpadding="8" cellspacing="0">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <% for (User u : users) { %>
                <tr>
                    <td><%=u.getId()%></td>
                    <td><%=u.getName()%></td>
                    <td><%=u.getEmail()%></td>
                    <td><%=u.getPhone()%></td>
                    <td><%=u.getRole()%></td>
                    <td>
                        <a href="<%=ctx%>/EditUserServlet?id=<%=u.getId()%>">Sửa</a>
                        |
                        <a href="<%=ctx%>/DeleteUserServlet?id=<%=u.getId()%>" onclick="return confirm('Xoá người dùng này?');">Xoá</a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>
<script src="<%=ctx%>/js/admin.js"></script>
</body>
</html>
