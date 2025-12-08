package controller.Login;

import Ulti.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "Servlet_DangKy", value = "/Servlet_DangKy")
public class Servlet_DangKy extends HttpServlet {

    // Xử lý khi người dùng truy cập trực tiếp bằng GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/home");
    }

    // Xử lý khi người dùng gửi form đăng ký bằng POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        // Trim dữ liệu
        fullName = fullName != null ? fullName.trim() : "";
        username = username != null ? username.trim() : "";
        email    = email != null ? email.trim() : "";
        phone    = phone != null ? phone.trim() : "";
        password = password != null ? password.trim() : "";
        confirm  = confirm != null ? confirm.trim() : "";

        // Kiểm tra dữ liệu đầu vào
        if (fullName.isEmpty() || username.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            request.getRequestDispatcher("/VIEW/Loin/Register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.getRequestDispatcher("/VIEW/Loin/Register.jsp").forward(request, response);
            return;
        }
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            request.getRequestDispatcher("/VIEW/Loin/Register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {

            // Kiểm tra trùng tên đăng nhập hoặc email
            String checkSql = "SELECT 1 FROM Dang_Nhap WHERE Ten_Dang_Nhap = ? OR Email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại.");
                        request.getRequestDispatcher("/VIEW/Loin/Register.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Thêm tài khoản mới
            String insertSql = "INSERT INTO Dang_Nhap (Ho_Va_Ten, Ten_Dang_Nhap, Email, Phone, Mat_Khau, Avatar_Path) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setString(1, fullName);
                insertStmt.setString(2, username);
                insertStmt.setString(3, email);
                insertStmt.setString(4, phone);
                insertStmt.setString(5, password); // Nên mã hóa trong thực tế
                insertStmt.setString(6, "/images/default-avatar.png");

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                    // Tạo cookie chào mừng
                    Cookie cookie = new Cookie("username", fullName);
                    cookie.setMaxAge(60 * 60);
                    response.addCookie(cookie);

                    // Chuyển đến trang chính
                    response.sendRedirect(request.getContextPath() + "/VIEW/index.jsp");
                } else {
                    request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                    request.getRequestDispatcher("/VIEW/Loin/Register.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống hoặc kết nối CSDL.");
            request.getRequestDispatcher("/VIEW/Loin/Register.jsp").forward(request, response);
        }
    }
}