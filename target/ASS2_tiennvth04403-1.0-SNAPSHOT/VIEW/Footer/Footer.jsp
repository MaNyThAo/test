<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<fmt:setBundle basename="i18n.messages"/>
<footer class="text-light pt-5 pb-4" style="background: #1e1e1e; margin-top: 80px;">
    <div class="container">

        <div class="row">

            <!-- Cột 1 - Logo + mô tả -->
            <div class="col-md-4 mb-4">
                <h3 class="fw-bold text-danger">YourBrand</h3>
                <p class="mt-3" style="line-height: 1.7;">
                    <fmt:message key="footer.about"/>
                </p>

                <div class="d-flex gap-3 mt-3">
                    <a href="#" class="text-light fs-4"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-light fs-4"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-light fs-4"><i class="bi bi-tiktok"></i></a>
                    <a href="#" class="text-light fs-4"><i class="bi bi-youtube"></i></a>
                </div>
            </div>

            <!-- Cột 2 - Danh mục -->
            <div class="col-md-2 mb-4">
                <h5 class="fw-bold mb-3"><fmt:message key="footer.menu"/></h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="menu.home"/></a></li>
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="menu.product"/></a></li>
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="menu.news"/></a></li>
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="menu.contact"/></a></li>
                </ul>
            </div>

            <!-- Cột 3 - Hỗ trợ -->
            <div class="col-md-3 mb-4">
                <h5 class="fw-bold mb-3"><fmt:message key="footer.policy"/></h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="footer.guide"/></a></li>
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="footer.return"/></a></li>
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="footer.privacy"/></a></li>
                    <li class="mb-2"><a href="#" class="text-light text-decoration-none hover-footer"><fmt:message key="footer.payment"/></a></li>
                </ul>
            </div>

            <!-- Cột 4 - Liên hệ -->
            <div class="col-md-3 mb-4">
                <h5 class="fw-bold mb-3"><fmt:message key="footer.contact"/></h5>
                <p><i class="bi bi-geo-alt-fill text-danger"></i> <fmt:message key="footer.address"/></p>
                <p><i class="bi bi-telephone-fill text-danger"></i> <fmt:message key="footer.phone"/></p>
                <p><i class="bi bi-envelope-fill text-danger"></i> <fmt:message key="footer.email"/></p>
            </div>

        </div>

        <!-- Gạch ngang -->
        <hr style="border-color: #444;">

        <!-- Dòng bản quyền -->
        <div class="text-center pt-2">
            © 2025 <span class="text-danger fw-bold">YourBrand</span>. <fmt:message key="footer.copyright"/>
        </div>

    </div>
</footer>

<!-- Hiệu ứng hover -->
<style>
    .hover-footer:hover {
        color: #ff5722 !important;
        padding-left: 4px;
        transition: 0.3s;
    }
</style>