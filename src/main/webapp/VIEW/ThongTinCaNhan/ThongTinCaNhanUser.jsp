<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <style>
        /* ... giữ nguyên phần CSS như bạn đã viết ... */
    </style>
</head>
<body>
<div class="header">
    <c:import url="/VIEW/Header/Header.jsp"></c:import>
</div>

<div class="container mt-5 mb-5">
    <br><br>
    <h2 class="text-center fw-bold mb-4">Thông tin tài khoản</h2>

    <!-- Thông báo -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <div class="row">
        <!-- Menu tài khoản -->
        <div class="col-md-3">
            <h5 class="fw-bold mb-3">Menu tài khoản</h5>
            <ul class="list-group">
                <li class="list-group-item">Thông tin cá nhân</li>
                <li class="list-group-item">Bảo mật</li>
                <li class="list-group-item">Quyền riêng tư</li>
                <li class="list-group-item">Tin đăng</li>
                <li class="list-group-item">Cài đặt</li>
            </ul>
        </div>

        <!-- Form cập nhật -->
        <div class="col-md-9">
            <form action="${pageContext.request.contextPath}/Servlet_ThongTinCaNhan" method="post" enctype="multipart/form-data">
                <input type="hidden" name="sellerID" value="${sessionScope.sellerID}">

                <div class="card p-4 shadow-sm">
                    <h5 class="fw-bold mb-4">Thông tin cơ bản</h5>

                    <div class="mb-3 text-center">
                        <img src="<c:out value='${sessionScope.avatarPath != null ? sessionScope.avatarPath : "/images/default-avatar.png"}'/>"
                             alt="Avatar" class="rounded-circle border" style="width: 120px; height: 120px;">
                        <input type="file" name="avatar" class="form-control mt-2">
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label><strong>Họ và tên:</strong></label>
                            <input type="text" name="Ho_Va_Ten" class="form-control" value="${sessionScope.Ho_Va_Ten}" required>
                        </div>
                        <div class="col-md-6">
                            <label><strong>Tên đăng nhập:</strong></label>
                            <input type="text" name="Ten_Dang_Nhap" class="form-control" value="${sessionScope.Ten_Dang_Nhap}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label><strong>Email:</strong></label>
                            <input type="email" name="Email" class="form-control" value="${sessionScope.Email}" required>
                        </div>
                        <div class="col-md-6">
                            <label><strong>Số điện thoại:</strong></label>
                            <input type="text" name="Phone" class="form-control" value="${sessionScope.Phone}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label><strong>Giới tính:</strong></label>
                            <select name="Gioi_Tinh" class="form-select" required>
                                <option value="">-- Chọn giới tính --</option>
                                <option value="Nam" ${sessionScope.Gioi_Tinh == 'Nam' ? 'selected' : ''}>Nam</option>
                                <option value="Nữ" ${sessionScope.Gioi_Tinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                <option value="Khác" ${sessionScope.Gioi_Tinh == 'Khác' ? 'selected' : ''}>Khác</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label><strong>Ngày sinh:</strong></label>
                            <input type="date" name="Ngay_Sinh" class="form-control" value="${sessionScope.Ngay_Sinh}" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label><strong>Số CMND/CCCD:</strong></label>
                        <input type="text" name="So_CCCD_CMND" class="form-control" value="${sessionScope.CCCD}" required>
                    </div>

                    <div class="mb-3">
                        <label><strong>Địa chỉ:</strong></label>
                        <input type="text" name="Dia_Chi" class="form-control" value="${sessionScope.Dia_Chi}" required>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label><strong>Mật khẩu:</strong></label>
                            <input type="password" name="Mat_Khau" class="form-control" value="${sessionScope.Mat_Khau}" required>
                        </div>
                        <div class="col-md-6">
                            <label><strong>Xác nhận mật khẩu:</strong></label>
                            <input type="password" name="Xac_Nhan_Mat_Khau" class="form-control" required>
                        </div>
                    </div>

                    <div class="text-end mt-4">
                        <button type="submit" class="btn btn-danger">Lưu</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>

</html>