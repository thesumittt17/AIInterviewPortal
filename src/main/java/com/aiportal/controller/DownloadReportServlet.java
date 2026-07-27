package com.aiportal.controller;

import com.aiportal.dao.InterviewHistoryDAO;
import com.aiportal.model.InterviewHistory;
import com.aiportal.model.OverallFeedbackResult;
import com.aiportal.model.User;
import com.aiportal.service.GeminiService;

import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/download-report")
public class DownloadReportServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // CHECK LOGGED-IN USER
        // =========================

        User user = (User) request.getSession()
                                  .getAttribute("user");

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/login.jsp"
            );

            return;
        }


        // =========================
        // FETCH INTERVIEW DATA
        // =========================

        InterviewHistoryDAO dao =
                new InterviewHistoryDAO();

        List<InterviewHistory> historyList =
                dao.getHistoryByUser(user.getId());

        double overallScore =
                dao.getOverallScoreByUser(user.getId());


        // =========================
        // GENERATE STRUCTURED
        // OVERALL AI FEEDBACK
        // =========================

        GeminiService geminiService =
                new GeminiService();

        OverallFeedbackResult overallFeedback =
                geminiService.generateOverallFeedback(
                        historyList,
                        overallScore
                );


        // =========================
        // CONFIGURE PDF RESPONSE
        // =========================

        response.setContentType("application/pdf");

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=AI_Interview_Report.pdf"
        );


        Document document = new Document();


        try {

            PdfWriter.getInstance(
                    document,
                    response.getOutputStream()
            );

            document.open();


            // =========================
            // FONTS
            // =========================

            Font titleFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA_BOLD,
                            20
                    );

            Font headingFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA_BOLD,
                            14
                    );

            Font subHeadingFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA_BOLD,
                            12
                    );

            Font normalFont =
                    FontFactory.getFont(
                            FontFactory.HELVETICA,
                            11
                    );


            // =========================
            // PDF TITLE
            // =========================

            Paragraph title =
                    new Paragraph(
                            "AI Interview Portal\nInterview Report",
                            titleFont
                    );

            title.setAlignment(
                    Paragraph.ALIGN_CENTER
            );

            title.setSpacingAfter(25);

            document.add(title);


            // =========================
            // CANDIDATE INFORMATION
            // =========================

            document.add(
                    new Paragraph(
                            "Candidate: " + user.getName(),
                            headingFont
                    )
            );

            document.add(
                    new Paragraph(
                            "Overall Score: "
                            + String.format("%.1f", overallScore)
                            + "/10",
                            headingFont
                    )
            );

            document.add(
                    new Paragraph("\n")
            );


            // =========================
            // OVERALL AI FEEDBACK
            // =========================

            document.add(
                    new Paragraph(
                            "Overall AI Feedback",
                            titleFont
                    )
            );

            document.add(
                    new Paragraph("\n")
            );


            // PERFORMANCE SUMMARY

            document.add(
                    new Paragraph(
                            "Performance Summary",
                            subHeadingFont
                    )
            );

            document.add(
                    new Paragraph(
                            overallFeedback.getPerformanceSummary(),
                            normalFont
                    )
            );

            document.add(
                    new Paragraph("\n")
            );


            // STRENGTHS

            document.add(
                    new Paragraph(
                            "Strengths",
                            subHeadingFont
                    )
            );

            if (overallFeedback.getStrengths() != null
                    && !overallFeedback.getStrengths().isEmpty()) {

                for (String strength :
                        overallFeedback.getStrengths()) {

                    document.add(
                            new Paragraph(
                                    "- " + strength,
                                    normalFont
                            )
                    );
                }

            } else {

                document.add(
                        new Paragraph(
                                "No specific strengths identified.",
                                normalFont
                        )
                );
            }

            document.add(
                    new Paragraph("\n")
            );


            // WEAKNESSES

            document.add(
                    new Paragraph(
                            "Weaknesses",
                            subHeadingFont
                    )
            );

            if (overallFeedback.getWeaknesses() != null
                    && !overallFeedback.getWeaknesses().isEmpty()) {

                for (String weakness :
                        overallFeedback.getWeaknesses()) {

                    document.add(
                            new Paragraph(
                                    "- " + weakness,
                                    normalFont
                            )
                    );
                }

            } else {

                document.add(
                        new Paragraph(
                                "No specific weaknesses identified.",
                                normalFont
                        )
                );
            }

            document.add(
                    new Paragraph("\n")
            );


            // AREAS FOR IMPROVEMENT

            document.add(
                    new Paragraph(
                            "Areas for Improvement",
                            subHeadingFont
                    )
            );

            if (overallFeedback.getAreasForImprovement() != null
                    && !overallFeedback
                        .getAreasForImprovement()
                        .isEmpty()) {

                for (String area :
                        overallFeedback
                            .getAreasForImprovement()) {

                    document.add(
                            new Paragraph(
                                    "- " + area,
                                    normalFont
                            )
                    );
                }

            } else {

                document.add(
                        new Paragraph(
                                "No specific improvement areas identified.",
                                normalFont
                        )
                );
            }


            document.add(
                    new Paragraph(
                            "\n----------------------------------------\n"
                    )
            );


            // =========================
            // INTERVIEW HISTORY
            // =========================

            document.add(
                    new Paragraph(
                            "Interview History",
                            titleFont
                    )
            );

            document.add(
                    new Paragraph("\n")
            );


            int questionNumber = 1;


            for (InterviewHistory history : historyList) {


                document.add(
                        new Paragraph(
                                "Question "
                                + questionNumber
                                + " - "
                                + history.getTopic(),
                                headingFont
                        )
                );


                document.add(
                        new Paragraph(
                                history.getQuestion(),
                                normalFont
                        )
                );


                document.add(
                        new Paragraph(
                                "\nYour Answer:",
                                subHeadingFont
                        )
                );


                document.add(
                        new Paragraph(
                                history.getUserAnswer(),
                                normalFont
                        )
                );


                document.add(
                        new Paragraph(
                                "\nScore: "
                                + history.getScore()
                                + "/10",
                                subHeadingFont
                        )
                );


                document.add(
                        new Paragraph(
                                "\nAI Feedback:",
                                subHeadingFont
                        )
                );


                document.add(
                        new Paragraph(
                                history.getFeedback(),
                                normalFont
                        )
                );


                document.add(
                        new Paragraph(
                                "\n----------------------------------------\n"
                        )
                );


                questionNumber++;
            }


            // =========================
            // FOOTER
            // =========================

            Paragraph footer =
                    new Paragraph(
                            "Generated by AI Interview Portal",
                            normalFont
                    );

            footer.setAlignment(
                    Paragraph.ALIGN_CENTER
            );

            document.add(footer);


        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            document.close();
        }
    }
}