<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}" scope="session"/>
<fmt:setBundle basename="i18n.messages"/>

<%
    Cookie[] cookies = request.getCookies();
    String username = "Khách";
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("username")) {
                username = c.getValue();
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="site.title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .nav-link { font-weight: 500; transition: 0.3s; }
        .nav-link:hover { color: #ff5722 !important; transform: translateY(-2px); }

        .user-menu { position: relative; display: inline-block; }
        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 180px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            z-index: 1000;
            border-radius: 6px;
        }
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover { background-color: #f1f1f1; }
        .search-box button { border-radius: 50px; }
    </style>
</head>

<body>

<!-- LẤY GIÁ TRỊ COOKIE username -->
<c:choose>
    <c:when test="${not empty cookie.username.value}">
        <c:set var="username" value="${cookie.username.value}" />
    </c:when>
    <c:otherwise>
        <c:set var="username" value="Khách" />
    </c:otherwise>
</c:choose>

<nav class="navbar navbar-expand-lg bg-white fixed-top">
    <div class="container">

        <a class="navbar-brand fw-bold fs-4 text-danger" href="#">
            <fmt:message key="site.title"/>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-3">
                <li class="nav-item">
                    <a class="nav-link active text-dark" href="${pageContext.request.contextPath}/home">
                        <fmt:message key="menu.home"/>
                    </a>
                </li>
                <li class="nav-item"><a class="nav-link text-dark" href="#"><fmt:message key="menu.product"/></a></li>
                <li class="nav-item"><a class="nav-link text-dark" href="#"><fmt:message key="menu.news"/></a></li>
                <li class="nav-item"><a class="nav-link text-dark" href="#"><fmt:message key="menu.contact"/></a></li>
            </ul>

            <form class="d-flex search-box me-3" role="search">
                <input class="form-control" type="search" placeholder="<fmt:message key='search.placeholder'/>">
                <button class="btn btn-danger ms-2"><fmt:message key="search.button"/></button>
            </form>

        </div>

        <!-- Ngôn ngữ -->
        <div class="lang-btn d-flex align-items-center gap-3 me-4">
            <a href="${pageContext.request.contextPath}/change-language?lang=vi">
                <img src="/images/vietnam.jpg" alt="Tiếng Việt" class="rounded shadow-sm" style="width: 32px; height: auto;">
            </a>
            <a href="${pageContext.request.contextPath}/change-language?lang=en">
                <img src="/images/American.png" alt="English" class="rounded shadow-sm" style="width: 32px; height: auto;">
            </a>
        </div>
        <!-- Kiểm tra chế độ khách -->
        <c:choose>
            <c:when test="${username eq 'Khách'}">
                <!-- Nếu là khách: hiển thị nút đăng nhập và đăng ký -->
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/Servlet_DangNhap" class="btn btn-outline-danger">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/Servlet_DangKy" class="btn btn-danger">Đăng ký</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Nếu đã đăng nhập: hiển thị ảnh đại diện và menu -->
                <div class="user-menu">
                    <div class="user-menu d-flex align-items-center gap-2 ms-3">
                        <p class="fw-semibold text-dark mb-0">👋 <fmt:message key="hello"/>, ${username}!</p>
                        <img src="/images/user.png" alt="Avatar" id="avatar"
                             class="rounded-circle border border-2"
                             style="width: 40px; height: 40px; cursor: pointer;" />
                    </div>

                    <div id="dropdownMenu" class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/Servlet_QLSanPham/load">📦 <fmt:message key="menu.manageProduct"/></a>
                        <a href="${pageContext.request.contextPath}/Servlet_ThongTinCaNhan">👤 <fmt:message key="menu.profile"/></a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 <fmt:message key="menu.logout"/></a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- NẾU CHƯA CÓ COOKIE username -->
        <c:if test="${empty username}">
            <a href="${pageContext.request.contextPath}/VIEW/Login.jsp"
               class="btn btn-outline-danger">Đăng nhập</a>
        </c:if>

    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const avatar = document.getElementById("avatar");
    const menu = document.getElementById("dropdownMenu");

    if (avatar && menu) {
        avatar.addEventListener("click", function () {
            menu.style.display = menu.style.display === "block" ? "none" : "block";
        });

        window.addEventListener("click", function (e) {
            if (!avatar.contains(e.target) && !menu.contains(e.target)) {
                menu.style.display = "none";
            }
        });
    }
</script>

</body>
</html>