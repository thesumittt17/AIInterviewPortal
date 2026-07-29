package com.aiportal.servlet;

import com.aiportal.dao.UserDAO;
import com.aiportal.model.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        
        
        String email = request.getParameter("email");

        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        User user = dao.loginUser(email, password);

        if(user!=null){

            HttpSession session=request.getSession();

            session.setAttribute("user",user);

           response.sendRedirect(request.getContextPath() + "/dashboard");
        }

        else{

            response.getWriter().println("Invalid Email or Password");

        }

    }

}