
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            cursor: pointer;
            color: white;
            border-radius: 4px;
        }
        .btn-edit {
            background-color: #f39c12;
        }
        .btn-delete {
            background-color: #e74c3c;
        }
        .btn-view {
            background-color: #3498db;
        }
        .btn-add{
            background: green;
        }
        /*modal*/
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 50%;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .close {
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        /* Form tìm kiếm và lọc */
        .filter-form {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 15px;
            background-color: #ffffff;
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .filter-form label {
            font-weight: bold;
            margin-right: 5px;
            color: #333;
        }

        .filter-form input[type="text"],
        .filter-form input[type="number"] {
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 180px;
            transition: border-color 0.3s;
        }

        .filter-form input:focus {
            border-color: #3498db;
            outline: none;
        }

        .filter-form button {
            padding: 8px 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .filter-form button:hover {
            background-color: #2980b9;
        }
        .btn-add {
            background-color: #2ecc71;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-add:hover {
            background-color: #27ae60;
            transform: scale(1.03);
        }

        .btn-add:active {
            background-color: #1e8449;
            transform: scale(0.98);
        }
    </style>
</head>
<body>

<div class = "Header">
    <c:import url="/VIEW/Header/Header.jsp"></c:import>
</div>

<h2>Danh sách sản phẩm</h2>
<div class = "add">

    <!-- Nút mở form -->
    <div class="add" style="margin-bottom: 20px;">
        <button class="btn-add" onclick="openForm()">Thêm sản phẩm</button>
    </div>

    <form method="get" action="${pageContext.request.contextPath}/Servlet_LTK" class="filter-form">
        <label for="keyword">Tìm theo tên:</label>
        <input type="text" id="keyword" name="keyword" value="${param.keyword}" placeholder="Nhập tên sản phẩm..."/>

        <label for="minPrice">Giá từ:</label>
        <input type="number" id="minPrice" name="minPrice" value="${param.minPrice}" />

        <label for="maxPrice">Đến:</label>
        <input type="number" id="maxPrice" name="maxPrice" value="${param.maxPrice}" />

        <button type="submit">Lọc</button>
    </form>

    <!-- Modal form -->
    <div id="formModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeForm()">&times;</span>
            <h2>Thêm mới phòng trọ</h2>
            <form action="${pageContext.request.contextPath}/Servlet_Add" method="post">
                <label>Tiêu đề:</label><br>
                <input type="text" name="title" required><br><br>

                <label>Trạng thái:</label><br>
                <select name="trang" required>
                    <option value="true">Còn phòng</option>
                    <option value="false">Hết phòng</option>
                </select><br><br>

                <label>Khu vực:</label><br>
                <input type="text" name="khu" required><br><br>

                <label>Giá thuê:</label><br>
                <input type="number" step="0.01" name="gia" required><br><br>

                <!-- Phần form ẩn ban đầu -->
                <div id="formThem" style="display: none;">
                    <label>Ngày cập nhật:</label><br>
                    <input type="datetime-local" name="date" ><br><br>
                </div>

                <button type="submit">Thêm phòng</button>
            </form>
        </div>
    </div>
</div>


<table>
    <thead>
    <tr>
        <th>Mã</th>
        <th>Tên</th>
        <th>Trạng thái</th>
        <th>Khu vực</th>
        <th>Giá thuê</th>
        <th>Ngày cập nhật</th>
        <th>Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${danhSach}" var="pt">
    <tr>
        <td>${pt.id}</td>
        <td>${pt.title}</td>
        <td>
            <c:choose>
                <c:when test="${pt.trang_Thai}">
                    Đang trống
                </c:when>
                <c:otherwise>
                    Đã hết
                </c:otherwise>
            </c:choose>
        </td>
        <td>${pt.khu_Vuc}</td>
        <td>${pt.gia_Thue}</td>
        <td>${pt.ngay_Cap_Nhap}</td>
        <td>
            <button class="btn btn-view" >
                <a href="${pageContext.request.contextPath}/Servlet_Detail?id=${pt.id}">Xem chi tiết</a>
            </button>
            <button class="btn btn-edit"><a href="${pageContext.request.contextPath}/Servlet_Edit?id=${pt.id}">Sửa</a></button>
            <button class="btn btn-delete"><a href="${pageContext.request.contextPath}/Servlet_Delete?id=${pt.id}">Xóa</a></button>
        </td>

    </tr>
    </c:forEach>
    </tbody>
</table>

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
