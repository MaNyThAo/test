package controller.Login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xóa cookie username

        Cookie cookie = new Cookie("username", "");
        cookie.setMaxAge(0); // Xóa ngay lập tức
        response.addCookie(cookie);

        // Nếu bạn dùng session, có thể hủy luôn
        request.getSession().invalidate();

        // Chuyển hướng về trang đăng nhập
        response.sendRedirect(request.getContextPath()+ "/home");
    }
}