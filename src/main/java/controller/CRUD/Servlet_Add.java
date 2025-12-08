package controller.CRUD;

import Reponsiroty.Repo_PhongTro;
import entity.PhongTro;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "Servlet_Add", value = "/Servlet_Add")
public class Servlet_Add extends HttpServlet {
    private Repo_PhongTro repo_phongTro = new Repo_PhongTro();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        Boolean trang_Thai = Boolean.parseBoolean(request.getParameter("trang"));
        String khuuu_VUc = request.getParameter("khu");
        Double gia_Thue = Double.parseDouble(request.getParameter("gia"));
        String dateStr = request.getParameter("date");
        Timestamp date;

        if (dateStr == null || dateStr.isEmpty()) {
            // Nếu không nhập, lấy thời điểm hiện tại
            date = new Timestamp(System.currentTimeMillis());
        } else {
            // Chuyển định dạng từ datetime-local sang Timestamp
            String normalized = dateStr.replace('T', ' ');
            if (normalized.length() == 16) { // yyyy-MM-dd HH:mm
                normalized += ":00"; // thêm giây nếu thiếu
            }
            date = Timestamp.valueOf(normalized);
        }


        PhongTro a = new PhongTro();
        a.setTitle(title);
        a.setTrang_Thai(trang_Thai);
        a.setKhu_Vuc(khuuu_VUc);
        a.setGia_Thue(gia_Thue);
        a.setNgay_Cap_Nhap(date);

        repo_phongTro.add(a);
        response.sendRedirect(request.getContextPath() + "/Servlet_QLSanPham");
    }
}
