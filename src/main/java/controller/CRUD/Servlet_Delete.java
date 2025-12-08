package controller.CRUD;

import Reponsiroty.Repo_PhongTro;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Servlet_Delete", value = "/Servlet_Delete")
public class Servlet_Delete extends HttpServlet {

    private Repo_PhongTro repo_phongTro = new Repo_PhongTro();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idTr = request.getParameter("id");
         int id = Integer.valueOf(idTr.trim());
        repo_phongTro.Delete(id);
        response.sendRedirect(request.getContextPath() + "/Servlet_QLSanPham");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
