<%--
  Created by IntelliJ IDEA.
  User: minht
  Date: 12/6/2025
  Time: 11:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fa;
            font-family: "Segoe UI", sans-serif;
        }

        .login-box {
            max-width: 420px;
            margin: 80px auto;
            background: white;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.12);
        }

        .login-title {
            font-size: 26px;
            font-weight: 700;
            color: #d32f2f;
        }

        .form-control {
            border-radius: 12px;
            padding: 10px 12px;
        }

        .btn-login {
            background: #d32f2f;
            color: white;
            border-radius: 12px;
            padding: 10px;
            font-size: 17px;
            transition: 0.25s;
        }

        .btn-login:hover {
            background: #b71c1c;
        }

        a {
            text-decoration: none;
            color: #d32f2f;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="login-box">
    <div class="text-center mb-4 login-title">Đăng nhập</div>

    <form action="${pageContext.request.contextPath}/Servlet_DangNhap" method="post">

        <label>Tên đăng nhập</label>
        <input type="text" name="username" class="form-control mb-3" placeholder="Nhập tên đăng nhập" >

        <label>Mật khẩu</label>
        <input type="password" name="password" class="form-control mb-4" placeholder="Nhập mật khẩu" >

        <input type="submit" class="btn btn-login w-100" value="Đăng nhập" />

        <div class="text-center mt-3">
            Chưa có tài khoản? <a href="/VIEW/Loin/Register.jsp">Đăng ký ngay</a>
        </div>
    </form>
</div>

</body>
</html>

