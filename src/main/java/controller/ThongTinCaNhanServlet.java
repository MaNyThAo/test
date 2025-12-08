package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Ulti.DBConnect;
import entity.DangNhap; // entity bạn sẽ tạo để map dữ liệu

@WebServlet(name = "Servlet_ThongTinCaNhan", value = "/Servlet_ThongTinCaNhan")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class ThongTinCaNhanServlet extends HttpServlet {

    private final String UPLOAD_DIR = "uploads/avatars";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String tenDangNhap = (String) session.getAttribute("Ten_Dang_Nhap");

        if (tenDangNhap != null) {
            try (Connection conn = DBConnect.getConnection()) {
                String sql = "SELECT sellerID, Ho_Va_Ten, Ten_Dang_Nhap, Email, Phone, Gioi_Tinh, Ngay_Sinh, CCCD, Dia_Chi, Mat_Khau, Avatar_Path " +
                        "FROM Dang_Nhap WHERE Ten_Dang_Nhap = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, tenDangNhap);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    DangNhap user = new DangNhap();
                    user.setSellerID(rs.getInt("sellerID"));
                    user.setHoVaTen(rs.getString("Ho_Va_Ten"));
                    user.setTenDangNhap(rs.getString("Ten_Dang_Nhap"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setGioiTinh(rs.getString("Gioi_Tinh"));
                    user.setNgaySinh(rs.getString("Ngay_Sinh"));
                    user.setCccd(rs.getString("CCCD"));
                    user.setDiaChi(rs.getString("Dia_Chi"));
                    user.setMatKhau(rs.getString("Mat_Khau"));
                    user.setAvatarPath(rs.getString("Avatar_Path"));

                    request.setAttribute("user", user);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Không thể tải dữ liệu từ CSDL: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("/VIEW/ThongTinCaNhan/ThongTinCaNhanUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        int sellerID = 0;
        try {
            sellerID = Integer.parseInt(request.getParameter("sellerID"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Servlet_ThongTinCaNhan");
            return;
        }

        String hoVaTen = getSafeParam(request, "Ho_Va_Ten");
        String tenDangNhap = getSafeParam(request, "Ten_Dang_Nhap");
        String email = getSafeParam(request, "Email");
        String phone = getSafeParam(request, "Phone");
        String gioiTinh = getSafeParam(request, "Gioi_Tinh");
        String ngaySinh = getSafeParam(request, "Ngay_Sinh");
        String soCCCD = getSafeParam(request, "So_CCCD_CMND");
        String diaChi = getSafeParam(request, "Dia_Chi");
        String matKhau = getSafeParam(request, "Mat_Khau");

        // Xử lý avatar
        String avatarPath = null;
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            avatarPath = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
        }

        try (Connection conn = DBConnect.getConnection()) {
            // Nếu không upload avatar mới, giữ nguyên avatar cũ
            if (avatarPath == null || avatarPath.isEmpty()) {
                String sqlAvatar = "SELECT Avatar_Path FROM Dang_Nhap WHERE sellerID=?";
                PreparedStatement psAvatar = conn.prepareStatement(sqlAvatar);
                psAvatar.setInt(1, sellerID);
                ResultSet rsAvatar = psAvatar.executeQuery();
                if (rsAvatar.next()) {
                    avatarPath = rsAvatar.getString("Avatar_Path");
                }
            }

            String sql = "UPDATE Dang_Nhap SET Ho_Va_Ten=?, Email=?, Phone=?, Mat_Khau=?, Avatar_Path=?, CCCD=?, Gioi_Tinh=?, Ngay_Sinh=?, Dia_Chi=? WHERE sellerID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, hoVaTen);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, matKhau);
            ps.setString(5, avatarPath);
            ps.setString(6, soCCCD);
            ps.setString(7, gioiTinh);
            ps.setString(8, ngaySinh);
            ps.setString(9, diaChi);
            ps.setInt(10, sellerID);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Sau khi cập nhật, chuyển hướng sang GET để load lại dữ liệu mới
        response.sendRedirect(request.getContextPath() + "/Servlet_ThongTinCaNhan");
    }

    // Hàm tiện ích để tránh null
    private String getSafeParam(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value != null ? value.trim() : "";
    }
}