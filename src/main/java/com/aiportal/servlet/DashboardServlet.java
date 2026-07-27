package com.aiportal.servlet;

import com.aiportal.dao.DashboardDAO;
import com.aiportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/pages/login.jsp"
            );
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        DashboardDAO dao = new DashboardDAO();

        // Dashboard Statistics
        session.setAttribute("totalInterviews",
                dao.getTotalInterviews(userId));

        session.setAttribute("averageScore",
                String.format("%.2f", dao.getAverageScore(userId)));

        session.setAttribute("highestScore",
                dao.getHighestScore(userId));

        session.setAttribute("lowestScore",
                dao.getLowestScore(userId));

        session.setAttribute("bestTopic",
                dao.getBestTopic(userId));

        session.setAttribute("weakestTopic",
                dao.getWeakestTopic(userId));

        session.setAttribute("topSkill",
                dao.getTopSkill(userId));

        // Chart Data
        request.setAttribute("scoreHistory",
                dao.getScoreHistory(userId));

        request.setAttribute("topicAverage",
                dao.getTopicWiseAverage(userId));

        System.out.println("==================================");
System.out.println("Score History : " + dao.getScoreHistory(userId));
System.out.println("Topic Average : " + dao.getTopicWiseAverage(userId));
System.out.println("==================================");
        
        
        request.getRequestDispatcher("/pages/dashboard.jsp")
                .forward(request, response);
    }
}