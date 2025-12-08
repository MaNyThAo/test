<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header Bootstrap Đẹp Không Icon</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .navbar {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .nav-link {
            font-weight: 500;
            transition: 0.25s;
        }

        .nav-link:hover {
            color: #ff5722 !important;
            transform: translateY(-2px);
        }

        .search-box input {
            border-radius: 30px;
            padding-left: 15px;
        }

        .search-box button {
            border-radius: 30px;
        }

        /* Hover nút đăng nhập */
        .btn-login:hover {
            background-color: #d43c2c;
        }

        /* Hover nút đăng ký */
        .btn-register:hover {
            background-color: #0d6efd;
            opacity: 0.85;
        }
    </style>
</head>

<body>

<!-- 🌟 HEADER MỚI – KHÔNG DÙNG ICON, KHÔNG AVATAR 🌟 -->
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <div class="container">

        <!-- Logo -->
        <a class="navbar-brand fw-bold fs-3 text-danger" href="#">
            YourBrand
        </a>

        <!-- Menu mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu chính -->
        <div class="collapse navbar-collapse" id="navbarNav">

            <ul class="navbar-nav me-auto ms-3">
                <li class="nav-item">
                    <a class="nav-link active text-dark" href="/VIEW/Main.jsp">Trang Chủ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-dark" href="#">Sản Phẩm</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-dark" href="#">Dịch vụ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-dark" href="#">Liên hệ</a>
                </li>
            </ul>

            <!-- Search -->
            <form class="d-flex search-box me-4">
                <input class="form-control" type="search" placeholder="Tìm kiếm sản phẩm...">
                <button class="btn btn-danger ms-2">Tìm</button>
            </form>

            <!-- Nút đăng nhập & đăng ký -->
            <div class="d-flex gap-3">

                <c:if test="${empty username}">
                    <a href="${pageContext.request.contextPath}/Servlet_DangNhap" class="btn btn-outline-danger">Đăng nhập</a>
                </c:if>

                <a href="${pageContext.request.contextPath}/Servlet_DangKy"  class="btn btn-outline-danger btn-register px-4">
                    Đăng ký
                </a>
            </div>
        </div>
    </div>
</nav>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
