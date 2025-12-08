<%--
  Created by IntelliJ IDEA.
  User: minht
  Date: 12/8/2025
  Time: 1:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
<h2>Đăng nhập</h2>
<form method="post" action="${pageContext.request.contextPath}/Servlet_DangNhap">
    <label for="username">Tên đăng nhập:</label><br>
    <input type="text" id="username" name="username" required><br><br>

    <label for="password">Mật khẩu:</label><br>
    <input type="password" id="password" name="password" required><br><br>

    <button type="submit">Đăng nhập</button>
</form>

<p style="color:red;">
    ${error != null ? error : ""}
</p>

<p>Chưa có tài khoản? <a href="Register.jsp">Đăng ký ngay</a></p>
</body>
</html>
