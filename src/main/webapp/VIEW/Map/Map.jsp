<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaflet Map + Danh Sách Phòng Trọ</title>

    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: auto;
        }

        /* Chia đôi layout */
        .container-map {
            display: flex;
            height: 100vh;
        }

        /* Map bên trái */
        #map {
            width: 50%;
            height: 100%;
        }

        /* Danh sách phòng */
        .room-list {
            width: 50%;
            overflow-y: auto;
            padding: 25px;
            background: #fafafa;
            border-left: 2px solid #ddd;
        }

        .room-card {
            padding: 15px;
            border-radius: 12px;
            background: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 18px;
            transition: 0.3s;
        }

        .room-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
        }

        .room-img {
            border-radius: 10px;
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .price {
            font-size: 18px;
            font-weight: bold;
            color: #e91e63;
        }
    </style>
</head>

<body>

<div class="container-map">

    <!-- Bản đồ -->
    <div id="map"></div>

    <!-- Danh sách phòng -->
    <div class="container py-5">
        <h3 class="fw-bold mb-4 text-center">Danh Sách Phòng Trọ</h3>

        <div class="row g-4">
            <c:forEach var="room" items="${rooms}">
                <div class="col-md-4">
                    <div class="room-card p-3 shadow-sm rounded">
                        <h5 class="mt-2">${room.title}</h5>
                        <p class="mb-1 text-secondary">Địa chỉ: ${room.khu_Vuc}</p>
                        <p class="price text-danger fw-semibold">
                            <fmt:formatNumber value="${room.gia_Thue}" type="number"/> đ / tháng
                        </p>
                        <p class="text-secondary">
                            <c:choose>
                                <c:when test="${room.trang_Thai}">Đang trống</c:when>
                                <c:otherwise>Đã hết</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-muted">Cập nhật: <fmt:formatDate value="${room.ngay_Cap_Nhap}" pattern="yyyy-MM-dd HH:mm"/></p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>



</div>

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<script>
    // Tạo map
    var map = L.map('map').setView([10.8411, 106.8093], 13); // toạ độ mặc định

    // Map style (tile layer)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);

    // Ví dụ gắn marker
    var marker = L.marker([10.8411, 106.8093]).addTo(map);
    marker.bindPopup("<b>Phòng Trọ Gần FPT</b><br>Giá: 3.500.000đ").openPopup();
</script>

</body>

</html>
