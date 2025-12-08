<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}" scope="session"/>
<fmt:setBundle basename="i18n.messages"/>
<html>
<head>
    <title>Main</title>
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


<div class="Header">
    <jsp:include page="/VIEW/Header/Header.jsp"></jsp:include>
</div>

<div class="container-map">

    <!-- Bản đồ -->
    <div id="map"></div>

    <!-- Danh sách phòng -->
    <div class="room-list">
        <h3 class="fw-bold mb-4 text-center"><fmt:message key="room.list.title"/></h3>

        <c:forEach var="room" items="${rooms}">
            <div class="room-card">
                <h5 class="mt-2">${room.title}</h5>
                <p class="mb-1 text-secondary">
                    <fmt:message key="room.address"/>: ${room.khu_Vuc}
                </p>
                <p class="price">
                    <fmt:formatNumber value="${room.gia_Thue}" type="number"/> <fmt:message key="room.price.unit"/>
                </p>
                <p class="text-secondary">
                    <c:choose>
                        <c:when test="${room.trang_Thai}">
                            <fmt:message key="status.available"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="status.unavailable"/>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="text-muted">
                    <fmt:message key="room.updated"/>:
                    <fmt:formatDate value="${room.ngay_Cap_Nhap}" pattern="yyyy-MM-dd HH:mm"/>
                </p>
            </div>
        </c:forEach>
    </div>
</div>

<div class="Footer">
    <jsp:include page="/VIEW/Footer/Footer.jsp"></jsp:include>
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

    // Ví dụ gắn nhiều marker với trạng thái và địa chỉ
    var products = [
        {coords: [10.8411, 106.8093], name: "Phòng Trọ Gần FPT", price: "3.500.000đ", status: "Còn trống", address: "123 Đường FPT, Quận 9"},
        {coords: [10.8420, 106.8100], name: "Phòng Trọ Cao Cấp", price: "4.200.000đ", status: "Đã thuê", address: "45 Đường Cao Thắng, Quận 9"},
        {coords: [10.8405, 106.8085], name: "Phòng Trọ Sinh Viên", price: "2.800.000đ", status: "Còn trống", address: "67 Đường Sinh Viên, Quận 9"},
        {coords: [10.8430, 106.8075], name: "Phòng Trọ Giá Rẻ", price: "2.200.000đ", status: "Còn trống", address: "12 Đường Rẻ, Quận 9"},
        {coords: [10.8440, 106.8090], name: "Phòng Trọ Full Nội Thất", price: "5.000.000đ", status: "Đang sửa chữa", address: "89 Đường Nội Thất, Quận 9"},
        {coords: [10.8450, 106.8105], name: "Phòng Trọ Gần Chợ", price: "3.000.000đ", status: "Còn trống", address: "22 Đường Chợ, Quận 9"},
        {coords: [10.8460, 106.8110], name: "Phòng Trọ Gần Trường", price: "3.200.000đ", status: "Đã thuê", address: "34 Đường Trường, Quận 9"},
        {coords: [10.8470, 106.8120], name: "Phòng Trọ Có Ban Công", price: "3.800.000đ", status: "Còn trống", address: "56 Đường Ban Công, Quận 9"},
        {coords: [10.8480, 106.8130], name: "Phòng Trọ Máy Lạnh", price: "4.500.000đ", status: "Còn trống", address: "78 Đường Máy Lạnh, Quận 9"},
        {coords: [10.8490, 106.8140], name: "Phòng Trọ Tiện Nghi", price: "4.000.000đ", status: "Đã thuê", address: "90 Đường Tiện Nghi, Quận 9"}
    ];

    // Thêm marker cho từng sản phẩm
    products.forEach(function(p) {
        var marker = L.marker(p.coords).addTo(map);
        marker.bindPopup(
            "<b>" + p.name + "</b><br>" +
            "Giá: " + p.price + "<br>" +
            "Trạng thái: " + p.status + "<br>" +
            "Địa chỉ: " + p.address
        );
    });
</script>

</body>
</html>