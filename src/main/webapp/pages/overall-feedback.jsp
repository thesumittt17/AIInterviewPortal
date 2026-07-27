<%@page import="java.util.List"%>
<%@page import="com.aiportal.model.InterviewHistory"%>
<%@page import="com.aiportal.model.OverallFeedbackResult"%>
<%@page import="com.aiportal.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(
            request.getContextPath() + "/pages/login.jsp"
        );
        return;
    }

    List<InterviewHistory> historyList =
        (List<InterviewHistory>) request.getAttribute("historyList");

    Double overallScore =
        (Double) request.getAttribute("overallScore");

    if (overallScore == null) {
        overallScore = 0.0;
    }

    OverallFeedbackResult overallFeedback =
        (OverallFeedbackResult)
        request.getAttribute("overallFeedback");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Overall Performance | AI Interview Portal</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', sans-serif;
}

body {
    min-height: 100vh;
    background: linear-gradient(135deg, #0f172a, #1e3a8a, #2563eb);
    color: white;
}

/* NAVBAR */

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 60px;
    background: rgba(255, 255, 255, 0.08);
    backdrop-filter: blur(15px);
}

.logo {
    font-size: 30px;
    font-weight: bold;
}

.back-btn {
    padding: 12px 22px;
    background: #4f46e5;
    color: white;
    text-decoration: none;
    border-radius: 10px;
    transition: 0.3s;
}

.back-btn:hover {
    background: #4338ca;
    transform: translateY(-2px);
}

/* CONTAINER */

.container {
    width: 90%;
    max-width: 1000px;
    margin: auto;
    padding: 50px 0;
}

/* HEADER */

.page-header {
    text-align: center;
    margin-bottom: 40px;
}

.page-header i {
    font-size: 55px;
    color: #00d4ff;
    margin-bottom: 15px;
}

.page-header h1 {
    font-size: 40px;
    margin-bottom: 10px;
}

.page-header p {
    color: #d1d5db;
    font-size: 18px;
}

/* OVERALL SCORE */

.overall-score {
    max-width: 350px;
    margin: 0 auto 35px;
    padding: 30px;
    text-align: center;
    background: rgba(255, 255, 255, 0.12);
    backdrop-filter: blur(18px);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-radius: 20px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
}

.overall-score i {
    font-size: 40px;
    color: #00d4ff;
    margin-bottom: 12px;
}

.overall-score h3 {
    margin-bottom: 10px;
    color: #dbeafe;
}

.score-number {
    font-size: 45px;
    font-weight: bold;
    color: #67e8f9;
}

/* FEEDBACK */

.overall-feedback {
    padding: 30px;
    background: rgba(255, 255, 255, 0.12);
    backdrop-filter: blur(18px);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-radius: 20px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
}

.overall-feedback > h2 {
    color: #67e8f9;
    font-size: 27px;
    margin-bottom: 25px;
}

.feedback-block {
    margin-top: 18px;
    padding: 20px;
    background: rgba(255, 255, 255, 0.07);
    border: 1px solid rgba(255, 255, 255, 0.10);
    border-radius: 14px;
}

.feedback-block h3 {
    color: #93c5fd;
    margin-bottom: 12px;
}

.feedback-block p,
.feedback-block li {
    color: #e5e7eb;
    line-height: 1.7;
}

.feedback-block ul {
    padding-left: 25px;
}

.feedback-block li {
    margin-bottom: 8px;
}

/* PDF BUTTON */

.download-section {
    text-align: center;
    margin-top: 35px;
}

.download-btn {
    display: inline-block;
    padding: 14px 25px;
    background: #ef4444;
    color: white;
    text-decoration: none;
    border-radius: 10px;
    font-weight: bold;
    transition: 0.3s;
}

.download-btn:hover {
    background: #dc2626;
    transform: translateY(-3px);
}

/* EMPTY */

.empty {
    text-align: center;
    padding: 60px 20px;
    background: rgba(255, 255, 255, 0.10);
    border-radius: 20px;
}

.empty i {
    font-size: 60px;
    color: #00d4ff;
    margin-bottom: 20px;
}

.empty p {
    margin-top: 10px;
    color: #d1d5db;
}

/* FOOTER */

.footer {
    text-align: center;
    color: #d1d5db;
    margin-top: 50px;
}

@media (max-width: 600px) {

    .navbar {
        padding: 18px 20px;
    }

    .logo {
        font-size: 21px;
    }

    .container {
        width: 92%;
    }

    .page-header h1 {
        font-size: 32px;
    }

    .overall-feedback {
        padding: 20px;
    }
}

</style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        AI Interview Portal
    </div>

    <a class="back-btn"
       href="${pageContext.request.contextPath}/pages/dashboard.jsp">

        <i class="fa-solid fa-arrow-left"></i>
        Dashboard

    </a>

</div>


<div class="container">

    <div class="page-header">

        <i class="fa-solid fa-chart-line"></i>

        <h1>Overall Performance</h1>

        <p>
            Analyze your complete interview performance
            and identify areas for improvement.
        </p>

    </div>


    <% if (historyList != null && !historyList.isEmpty()) { %>


        <!-- OVERALL SCORE -->

        <div class="overall-score">

            <i class="fa-solid fa-trophy"></i>

            <h3>Overall Score</h3>

            <div class="score-number">
                <%= String.format("%.1f", overallScore) %>/10
            </div>

        </div>


        <% if (overallFeedback != null) { %>

        <!-- OVERALL AI FEEDBACK -->

        <div class="overall-feedback">

            <h2>
                <i class="fa-solid fa-robot"></i>
                Overall AI Feedback
            </h2>


            <div class="feedback-block">

                <h3>📊 Performance Summary</h3>

                <p>
                    <%= overallFeedback.getPerformanceSummary() %>
                </p>

            </div>


            <div class="feedback-block">

                <h3>✅ Strengths</h3>

                <ul>

                <%
                    if (overallFeedback.getStrengths() != null
                        && !overallFeedback.getStrengths().isEmpty()) {

                        for (String strength :
                                overallFeedback.getStrengths()) {
                %>

                    <li><%= strength %></li>

                <%
                        }
                    } else {
                %>

                    <li>No specific strengths identified.</li>

                <%
                    }
                %>

                </ul>

            </div>


            <div class="feedback-block">

                <h3>⚠️ Weaknesses</h3>

                <ul>

                <%
                    if (overallFeedback.getWeaknesses() != null
                        && !overallFeedback.getWeaknesses().isEmpty()) {

                        for (String weakness :
                                overallFeedback.getWeaknesses()) {
                %>

                    <li><%= weakness %></li>

                <%
                        }
                    } else {
                %>

                    <li>No specific weaknesses identified.</li>

                <%
                    }
                %>

                </ul>

            </div>


            <div class="feedback-block">

                <h3>🎯 Areas for Improvement</h3>

                <ul>

                <%
                    if (overallFeedback.getAreasForImprovement() != null
                        && !overallFeedback.getAreasForImprovement().isEmpty()) {

                        for (String area :
                                overallFeedback.getAreasForImprovement()) {
                %>

                    <li><%= area %></li>

                <%
                        }
                    } else {
                %>

                    <li>No specific improvement areas identified.</li>

                <%
                    }
                %>

                </ul>

            </div>

        </div>


        <!-- PDF DOWNLOAD -->

        <div class="download-section">

            <a class="download-btn"
               href="${pageContext.request.contextPath}/download-report">

                <i class="fa-solid fa-file-pdf"></i>
                Download PDF Report

            </a>

        </div>

        <% } %>


    <% } else { %>


        <div class="empty">

            <i class="fa-solid fa-chart-column"></i>

            <h2>No Performance Data Yet</h2>

            <p>
                Complete some interview questions first
                to generate your overall performance analysis.
            </p>

        </div>


    <% } %>


    <div class="footer">
        AI Interview Portal © 2026
    </div>

</div>

</body>
</html>