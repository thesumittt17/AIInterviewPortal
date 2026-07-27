package com.aiportal.controller;

import com.aiportal.dao.InterviewHistoryDAO;
import com.aiportal.model.InterviewHistory;
import com.aiportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get logged-in user
        User user = (User) request
                .getSession()
                .getAttribute("user");

        // If user is not logged in
        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/login.jsp"
            );

            return;
        }

        // Create DAO object
        InterviewHistoryDAO dao =
                new InterviewHistoryDAO();

        // Get only the logged-in user's interview history
        List<InterviewHistory> historyList =
                dao.getHistoryByUser(user.getId());

        // Send history data to history.jsp
        request.setAttribute(
                "historyList",
                historyList
        );

        // Open history page
        request.getRequestDispatcher(
                "/pages/history.jsp"
        ).forward(request, response);
    }
}