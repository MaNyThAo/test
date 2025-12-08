package controller.CRUD;

import Reponsiroty.Repo_PhongTro;
import entity.PhongTro;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "Servlet_Detail", value = "/Servlet_Detail")
public class Servlet_Detail extends HttpServlet {

    private Repo_PhongTro repo_phongTro = new Repo_PhongTro();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        PhongTro phongTro = repo_phongTro.detail(id);
        request.setAttribute("phongTro",phongTro);
        request.getRequestDispatcher("/VIEW/SanPham/Dentai.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
