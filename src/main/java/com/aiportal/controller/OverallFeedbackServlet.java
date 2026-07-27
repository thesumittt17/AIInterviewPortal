package com.aiportal.controller;

import com.aiportal.dao.InterviewHistoryDAO;
import com.aiportal.model.InterviewHistory;
import com.aiportal.model.OverallFeedbackResult;
import com.aiportal.model.User;
import com.aiportal.service.GeminiService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/overall-feedback")
public class OverallFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get logged-in user
        User user = (User) request
                .getSession()
                .getAttribute("user");

        // Check login
        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/login.jsp"
            );

            return;
        }

        // Create DAO
        InterviewHistoryDAO dao =
                new InterviewHistoryDAO();

        // Get user's complete interview history
        List<InterviewHistory> historyList =
                dao.getHistoryByUser(user.getId());

        // Calculate overall score
        double overallScore =
                dao.getOverallScoreByUser(user.getId());

        // Generate overall feedback only if history exists
        OverallFeedbackResult overallFeedback = null;

        if (historyList != null
                && !historyList.isEmpty()) {

            GeminiService geminiService =
                    new GeminiService();

            overallFeedback =
                    geminiService.generateOverallFeedback(
                            historyList,
                            overallScore
                    );
        }

        // Send data to JSP
        request.setAttribute(
                "overallScore",
                overallScore
        );

        request.setAttribute(
                "overallFeedback",
                overallFeedback
        );

        request.setAttribute(
                "historyList",
                historyList
        );

        // Open separate Overall Performance page
        request.getRequestDispatcher(
                "/pages/overall-feedback.jsp"
        ).forward(request, response);
    }
}