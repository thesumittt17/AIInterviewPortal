package com.aiportal.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/InterviewServlet")
public class InterviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String topic = request.getParameter("topic");

        request.setAttribute("topic", topic);

        request.getRequestDispatcher("/pages/interview.jsp")
               .forward(request, response);
    }
}