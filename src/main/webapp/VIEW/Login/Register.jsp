<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background: #f8f9fa; font-family: "Segoe UI", sans-serif; }
        .register-box { max-width: 480px; margin: 80px auto; background: white; border-radius: 16px; padding: 40px; box-shadow: 0 4px 18px rgba(0,0,0,0.12); }
        .title { font-size: 28px; font-weight: 700; color: #d32f2f; }
        .form-control { border-radius: 12px; padding: 10px 12px; }
        .btn-register { background: #d32f2f; color: white; border-radius: 12px; padding: 10px; font-size: 17px; transition: 0.25s; }
        .btn-register:hover { background: #b71c1c; }
        a { text-decoration: none; color: #d32f2f; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="register-box">
    <div class="text-center mb-4 title">Đăng ký tài khoản</div>

    <!-- Hiển thị thông báo lỗi từ Servlet (nếu có) -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert">${success}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/Servlet_DangKy" method="post" accept-charset="UTF-8" id="registerForm">
        <label>Họ và tên</label>
        <input type="text" name="fullName" class="form-control mb-3" placeholder="Nhập họ tên" required>

        <label>Tên đăng nhập</label>
        <input type="text" name="username" class="form-control mb-3" placeholder="Nhập tên đăng nhập" required>

        <label>Email</label>
        <input type="email" name="email" class="form-control mb-3" placeholder="Nhập email" required>

        <label>Số điện thoại</label>
        <input type="text" name="phone" class="form-control mb-3" placeholder="Nhập số điện thoại" required>

        <label>Mật khẩu</label>
        <input type="password" name="password" class="form-control mb-3" placeholder="Tạo mật khẩu" required minlength="6">

        <label>Nhập lại mật khẩu</label>
        <input type="password" name="confirmPassword" class="form-control mb-4" placeholder="Xác nhận mật khẩu" required minlength="6">

        <input type="submit" value="Đăng ký" class="btn btn-register w-100" />

        <div class="text-center mt-3">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/VIEW/Loin/Login.jsp">Đăng nhập ngay</a>
        </div>
    </form>
</div>

<script>
    // Kiểm tra confirm password ở client
    const form = document.getElementById("registerForm");
    form.addEventListener("submit", function (e) {
        const pw = form.password.value.trim();
        const cf = form.confirmPassword.value.trim();
        if (pw !== cf) {
            e.preventDefault();
            alert("Mật khẩu xác nhận không khớp. Vui lòng kiểm tra lại.");
        }
    });
</script>

</body>
</html>