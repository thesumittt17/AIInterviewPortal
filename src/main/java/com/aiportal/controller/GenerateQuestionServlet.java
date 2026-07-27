package com.aiportal.controller;

import com.aiportal.service.GeminiService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/generate-question")
public class GenerateQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String topic = request.getParameter("topic");

        HttpSession session = request.getSession();

        String previousQuestion =
                (String) session.getAttribute("previousQuestion");

        if (previousQuestion == null) {
            previousQuestion = "None";
        }

        GeminiService service = new GeminiService();

        String question =
                service.generateQuestion(topic, previousQuestion);

        session.setAttribute("previousQuestion", question);

        request.setAttribute("topic", topic);
        request.setAttribute("question", question);

        request.getRequestDispatcher("/pages/question.jsp")
               .forward(request, response);
    }
}