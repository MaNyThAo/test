package controller.Login;

import Ulti.DBConnect;
import controller.mail.EmailService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "Servlet_DangNhap", value = "/Servlet_DangNhap")
public class Servlet_DangNhap extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.sendRedirect("VIEW/Login/Login.jsp"); // sửa "Loin" thành "Login"
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra đầu vào rỗng
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            request.getRequestDispatcher("VIEW/Login/Login.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            String sql = "SELECT * FROM Dang_Nhap WHERE Ten_Dang_Nhap=? AND Mat_Khau=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username.trim());
            stmt.setString(2, password.trim());

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("sellerID", rs.getInt("sellerID"));
                session.setAttribute("Ten_Dang_Nhap", rs.getString("Ten_Dang_Nhap"));
                session.setAttribute("Ho_Va_Ten", rs.getString("Ho_Va_Ten"));
                session.setAttribute("Email", rs.getString("Email"));
                session.setAttribute("Phone", rs.getString("Phone"));
                session.setAttribute("Gioi_Tinh", rs.getString("Gioi_Tinh"));

                // Kiểm tra cột Ngay_Sinh có tồn tại không
                try {
                    session.setAttribute("Ngay_Sinh", rs.getString("Ngay_Sinh"));
                } catch (SQLException ignore) {
                    // Nếu không có cột Ngay_Sinh thì bỏ qua
                }

                session.setAttribute("CCCD", rs.getString("CCCD"));
                session.setAttribute("Dia_Chi", rs.getString("Dia_Chi"));
                session.setAttribute("avatarPath", rs.getString("Avatar_Path"));
                // KHÔNG lưu mật khẩu vào session

                // Gửi email cảnh báo đăng nhập
                String loginTime = LocalDateTime.now()
                        .format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
                EmailService.sendWarningEmail(rs.getString("Email"), rs.getString("Ho_Va_Ten"), loginTime);
                // Tạo cookie lưu tên đăng nhập
                Cookie userCookie = new Cookie("username", rs.getString("Ten_Dang_Nhap"));
                userCookie.setMaxAge(60 * 60); // tồn tại 1 giờ
                userCookie.setPath("/"); // dùng được toàn bộ ứng dụng
                response.addCookie(userCookie);

                // Chuyển hướng sau đăng nhập
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu.");
                request.getRequestDispatcher("VIEW/Login/Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("VIEW/Login/Login.jsp").forward(request, response);
        }
    }
}