<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết phòng </title>
</head>
<body>
<h1>Thông tin chi tiết trọ phòng </h1>

<c:if test="${not empty phongTro}">
    <table border="1" cellpadding="8">
        <tr><th>ID</th><td>${phongTro.id}</td></tr>
        <tr><th>Tiêu đề</th><td>${phongTro.title}</td></tr>
        <tr>
            <th>Trạng thái</th>
            <td>
                <c:choose>
                    <c:when test="${phongTro.trang_Thai}">
                        Đang trống
                    </c:when>
                    <c:otherwise>
                        Đã hết
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr><th>Khu vực</th><td>${phongTro.khu_Vuc}</td></tr>
        <tr><th>Giá Thuê</th><td>${phongTro.gia_Thue}</td></tr>
        <tr><th>Ngày cập nhập</th><td>${phongTro.ngay_Cap_Nhap}</td></tr>
    </table>
</c:if>

<a href="${pageContext.request.contextPath}/Servlet_QLSanPham/load">Quay lại danh sách</a>

<br>
</body>
</html>