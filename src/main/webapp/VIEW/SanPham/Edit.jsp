<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sửa thông tin phòng trọ</title>
</head>
<body>
<h1>Sửa thông tin phòng trọ</h1>

<form action="${pageContext.request.contextPath}/Servlet_Edit" method="post">
    <input type="hidden" name="id" value="${phongTro.id}">

    Tiêu đề: <input type="text" name="title" value="${phongTro.title}"><br>

    Trạng thái:
    <select name="trang">
        <option value="">Đã hết</option>
        <option value="true" <c:if test="${phongTro.trang_Thai}">selected</c:if>>Đang trống</option>
    </select><br>

    Khu vực: <input type="text" name="khu" value="${phongTro.khu_Vuc}"><br>

    Giá thuê: <input type="number" name="gia" value="${phongTro.gia_Thue}"><br>

    <div id="formThem" style="display: none;">
    Ngày cập nhật:
    <input type="datetime-local" name="date"
           value="<c:out value='${phongTro.ngay_Cap_Nhap}'/>"><br>
    </div>
    <input type="submit" value="Cập nhật">
</form>

<a href="${pageContext.request.contextPath}/Servlet_QLSanPham/load">Quay lại danh sách</a>

<script>
    function openForm() {
        document.getElementById("formModal").style.display = "block";
    }

    function closeForm() {
        document.getElementById("formModal").style.display = "none";
    }
    document.getElementById('addForm').addEventListener('submit', function () {
        document.getElementById('formThem').style.display = 'block';
    });

</script>
</body>
</html>