package controller;

import Reponsiroty.Repo_PhongTro;
import entity.PhongTro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private Repo_PhongTro repo = new Repo_PhongTro();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        List<PhongTro> rooms = repo.getAll();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/VIEW/index.jsp").forward(request, response);
    }
}