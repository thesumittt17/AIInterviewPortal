package com.aiportal.servlet;

import com.aiportal.model.ResumeAnalysisResult;
import com.aiportal.service.GeminiService;
import com.aiportal.util.PDFUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet("/upload-resume")
@MultipartConfig
public class ResumeUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Get uploaded PDF
            Part resume = request.getPart("resume");

            if (resume == null || resume.getSize() == 0) {
                request.setAttribute("error",
                        "Please upload a valid resume.");
                request.getRequestDispatcher("/pages/resume-upload.jsp")
                        .forward(request, response);
                return;
            }

            // Extract text from PDF
            String resumeText = PDFUtil.extractText(resume.getInputStream());

            if (resumeText == null || resumeText.trim().isEmpty()) {
                request.setAttribute("error",
                        "Unable to extract text from the uploaded PDF.");
                request.getRequestDispatcher("/pages/resume-upload.jsp")
                        .forward(request, response);
                return;
            }

            // Analyze resume using Gemini AI
            GeminiService service = new GeminiService();

            ResumeAnalysisResult result =
                    service.analyzeResume(resumeText);

            // Debug output
            System.out.println("========== RESUME ANALYSIS ==========");
            System.out.println("Resume Score : " + result.getResumeScore());
            System.out.println("ATS Score    : " + result.getAtsScore());
            System.out.println("Strengths    : " + result.getStrengths());
            System.out.println("Weaknesses   : " + result.getWeaknesses());
            System.out.println("MissingSkill : " + result.getMissingSkills());
            System.out.println("Suggestions  : " + result.getSuggestions());
            System.out.println("Topics       : " + result.getRecommendedTopics());
            System.out.println("=====================================");

            // Send data to JSP
            request.setAttribute("analysis", result);
            request.setAttribute("fileName",
                    resume.getSubmittedFileName());

            // Open result page
            request.getRequestDispatcher("/pages/resume-result.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("error",
                    "Unable to analyze resume. Please try again.");

            request.getRequestDispatcher("/pages/resume-upload.jsp")
                    .forward(request, response);
        }
    }
}