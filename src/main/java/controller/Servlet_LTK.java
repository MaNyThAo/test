package controller;

import Reponsiroty.Repo_PhongTro;
import entity.PhongTro;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Servlet_LTK", value = "/Servlet_LTK")
public class Servlet_LTK extends HttpServlet {
    private Repo_PhongTro repo_phongTro = new Repo_PhongTro();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;

        List<PhongTro> danhSachGoc = repo_phongTro.getAll(); // Lấy toàn bộ danh sách từ DB
        List<PhongTro> danhSachLoc = new ArrayList<>();

        for (PhongTro pt : danhSachGoc) {
            boolean matchKeyword = (keyword == null || keyword.isEmpty()) || pt.getTitle().toLowerCase().contains(keyword.toLowerCase());
            boolean matchMin = (minPrice == null) || pt.getGia_Thue() >= minPrice;
            boolean matchMax = (maxPrice == null) || pt.getGia_Thue() <= maxPrice;

            if (matchKeyword && matchMin && matchMax) {
                danhSachLoc.add(pt);
            }
        }

        request.setAttribute("danhSach", danhSachLoc);
        request.getRequestDispatcher("/VIEW/SanPham/QLSanPham.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
