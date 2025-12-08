package controller.CRUD;

import Reponsiroty.Repo_PhongTro;
import entity.PhongTro;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Servlet_QLSanPham", value = {"/Servlet_QLSanPham","/Servlet_QLSanPham/load"})
public class Servlet_QLSanPham extends HttpServlet {
    private Repo_PhongTro repo_phongTro = new Repo_PhongTro();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PhongTro> danhSach = repo_phongTro.getAll();
        request.setAttribute("danhSach",danhSach);
        request.getRequestDispatcher("/VIEW/SanPham/QLSanPham.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
