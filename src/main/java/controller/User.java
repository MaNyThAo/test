package controller;

import Ulti.DBConnect;
import entity.DangNhapModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "User", value = "/User")
public class User extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection conn = DBConnect.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Dang_Nhap");

            // Tạo list để chứa dữ liệu
            List<DangNhapModel> list = new ArrayList<>();
            while (rs.next()) {
                DangNhapModel dn = new DangNhapModel();
                dn.setSellerID(rs.getInt("sellerID"));
                dn.setHoVaTen(rs.getString("Ho_Va_Ten"));
                dn.setTenDangNhap(rs.getString("Ten_Dang_Nhap"));
                dn.setEmail(rs.getString("Email"));
                dn.setPhone(rs.getString("Phone"));
                list.add(dn);
            }

            // Đưa dữ liệu sang JSP
            request.setAttribute("listDangNhap", list);
            request.getRequestDispatcher("/VIEW/ThongTinCaNhan/ThongTinCaNhanUser.jsp").forward(request, response);

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String hoVaTen = request.getParameter("Ho_Va_Ten");
        String tenDangNhap = request.getParameter("Ten_Dang_Nhap");
        String email = request.getParameter("Email");
        String phone = request.getParameter("Phone");
        String gioiTinh = request.getParameter("Gioi_Tinh");
        String ngaySinh = request.getParameter("Ngay_Sinh");
        String soCCCD = request.getParameter("So_CCCD_CMND");

        try {
            Connection conn = DBConnect.getConnection();
            String sql = "INSERT INTO Dang_Nhap (Ho_Va_Ten, Ten_Dang_Nhap, Email, Phone, Gioi_Tinh, Ngay_Sinh, So_CCCD_CMND) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, hoVaTen);
            ps.setString(2, tenDangNhap);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, gioiTinh);
            ps.setString(6, ngaySinh);
            ps.setString(7, soCCCD);

            int row = ps.executeUpdate();
            if (row > 0) {
                request.setAttribute("message", "Lưu thông tin thành công!");
            } else {
                request.setAttribute("message", "Không thể lưu thông tin.");
            }

            request.getRequestDispatcher("/VIEW/ThongTinCaNhan/ThongTinCaNhanUser.jsp").forward(request, response);

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }

    }

}