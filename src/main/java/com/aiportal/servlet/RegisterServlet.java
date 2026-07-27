package com.aiportal.servlet;

import com.aiportal.dao.UserDAO;
import com.aiportal.model.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
  
    User user = new User();
    user.setName(name);
    user.setEmail(email);
    user.setPassword(password);

    UserDAO dao = new UserDAO();

// Check if email already exists
User existingUser = dao.findByEmail(email);

if (existingUser != null) {

    request.setAttribute("status", "error");
    request.setAttribute("message", "Email already registered!");

    request.getRequestDispatcher("/pages/register.jsp")
           .forward(request, response);

    return;
}

// Register new user
boolean status = dao.registerUser(user);

if (status) {

    request.setAttribute("status", "success");
request.setAttribute("message", "Registration Successful!");
request.getRequestDispatcher("/pages/register.jsp").forward(request, response);

} else {
request.setAttribute("status", "error");
request.setAttribute("message", "Registration Failed!");
request.getRequestDispatcher("/pages/register.jsp").forward(request, response);

}
}

}