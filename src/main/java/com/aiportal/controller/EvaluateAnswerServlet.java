package com.aiportal.controller;

import com.aiportal.dao.InterviewHistoryDAO;
import com.aiportal.model.EvaluationResult;
import com.aiportal.model.InterviewHistory;
import com.aiportal.model.User;
import com.aiportal.service.GeminiService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/evaluate-answer")
public class EvaluateAnswerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
System.out.println("========== EVALUATE SERVLET CALLED ==========");
        String topic = request.getParameter("topic");
        String question = request.getParameter("question");
        String answer = request.getParameter("answer");

        // Get logged-in user
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(
                request.getContextPath() + "/pages/login.jsp"
            );
            return;
        }

        System.out.println("LOGGED USER ID: " + user.getId());

        // =========================================
        // CASE 1: NOT ATTEMPTED
        // =========================================
        if (answer == null || answer.trim().isEmpty()) {

            answer = "Not Attempted";

            InterviewHistory history = new InterviewHistory(
                    user.getId(),
                    topic,
                    question,
                    answer,
                    0,
                    ""
            );
            System.out.println("========== ABOUT TO SAVE HISTORY ==========");

            InterviewHistoryDAO historyDAO =
                    new InterviewHistoryDAO();

            boolean saved =
                    historyDAO.saveHistory(history);

            System.out.println(
                    "NOT ATTEMPTED HISTORY SAVED: " + saved
            );

            request.setAttribute("topic", topic);
            request.setAttribute("question", question);
            request.setAttribute("answer", "Not Attempted");
            request.setAttribute("score", 0);
            request.setAttribute("feedback", "");
            request.setAttribute(
                    "missingPoints",
                    java.util.List.of("Not Attempted")
            );
            request.setAttribute("betterAnswer", "");

            request.getRequestDispatcher("/pages/result.jsp")
                   .forward(request, response);

            return;
        }

        // =========================================
        // CASE 2: ATTEMPTED - AI EVALUATION
        // =========================================

        GeminiService service = new GeminiService();

        EvaluationResult evaluation =
                service.evaluateAnswer(topic, question, answer);
        
        System.out.println("========== EVALUATION OBJECT ==========");
System.out.println("Score: " + evaluation.getScore());
System.out.println("Feedback: " + evaluation.getFeedback());
System.out.println("Difficulty: " + evaluation.getDifficulty());
System.out.println("Confidence: " + evaluation.getConfidence());
System.out.println("Strengths: " + evaluation.getStrengths());
System.out.println("Weaknesses: " + evaluation.getWeaknesses());
System.out.println("=======================================");


        InterviewHistory history = new InterviewHistory(
                user.getId(),
                topic,
                question,
                answer,
                evaluation.getScore(),
                evaluation.getFeedback()
        );
        
        System.out.println("========== HISTORY DEBUG ==========");
System.out.println("User ID: " + user.getId());
System.out.println("Topic: " + topic);
System.out.println("Question: " + question);
System.out.println("Answer: " + answer);
System.out.println("Score: " + evaluation.getScore());

        InterviewHistoryDAO historyDAO =
                new InterviewHistoryDAO();

        boolean saved =
                historyDAO.saveHistory(history);

        System.out.println(
                "ATTEMPTED HISTORY SAVED: " + saved
        );

        // Send result to JSP
        request.setAttribute("topic", topic);
        request.setAttribute("question", question);
        request.setAttribute("answer", answer);
        request.setAttribute("score", evaluation.getScore());
        request.setAttribute("feedback", evaluation.getFeedback());
        request.setAttribute(
                "missingPoints",
                evaluation.getMissingPoints()
        );
        request.setAttribute(
                "betterAnswer",
                evaluation.getBetterAnswer()
        );
        
        request.setAttribute(
        "strengths",
        evaluation.getStrengths()
);

request.setAttribute(
        "weaknesses",
        evaluation.getWeaknesses()
);

request.setAttribute(
        "difficulty",
        evaluation.getDifficulty()
);

request.setAttribute(
        "confidence",
        evaluation.getConfidence()
);

        request.getRequestDispatcher("/pages/result.jsp")
               .forward(request, response);
    }
}