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
        (List<InterviewHistory>)
        request.getAttribute("historyList");

    

    OverallFeedbackResult overallFeedback =
        (OverallFeedbackResult)
        request.getAttribute("overallFeedback");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Interview History | AI Interview Portal
</title>

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
    background:
        linear-gradient(
            135deg,
            #0f172a,
            #1e3a8a,
            #2563eb
        );
    color: white;
}


/* =========================
   NAVBAR
========================= */

.navbar {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 60px;

    background:
        rgba(255, 255, 255, 0.08);

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


/* =========================
   MAIN CONTAINER
========================= */

.container {
    width: 90%;
    max-width: 1100px;
    margin: auto;
    padding: 50px 0;
}


/* =========================
   PAGE HEADER
========================= */

.page-header {
    text-align: center;
    margin-bottom: 35px;
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


/* =========================
   OVERALL SCORE
========================= */

.overall-score {
    max-width: 350px;
    margin: 0 auto 35px;
    padding: 28px;
    text-align: center;

    background:
        rgba(255, 255, 255, 0.12);

    backdrop-filter: blur(18px);

    border:
        1px solid
        rgba(255, 255, 255, 0.15);

    border-radius: 20px;

    box-shadow:
        0 10px 25px
        rgba(0, 0, 0, 0.25);

    transition: 0.3s;
}

.overall-score:hover {
    transform: translateY(-5px);

    background:
        rgba(255, 255, 255, 0.17);
}

.overall-score i {
    font-size: 38px;
    color: #00d4ff;
    margin-bottom: 12px;
}

.overall-score h3 {
    font-size: 20px;
    margin-bottom: 10px;
    color: #dbeafe;
}

.score-number {
    font-size: 42px;
    font-weight: bold;
    color: #67e8f9;
}


/* =========================
   OVERALL AI FEEDBACK
========================= */

.overall-feedback {
    margin-bottom: 35px;
    padding: 30px;

    background:
        rgba(255, 255, 255, 0.12);

    backdrop-filter: blur(18px);

    border:
        1px solid
        rgba(255, 255, 255, 0.15);

    border-radius: 20px;

    box-shadow:
        0 10px 25px
        rgba(0, 0, 0, 0.25);
}

.overall-feedback > h2 {
    color: #67e8f9;
    font-size: 27px;
    margin-bottom: 25px;
}

.overall-feedback > h2 i {
    margin-right: 8px;
}


/* FEEDBACK BLOCK */

.feedback-block {
    margin-top: 18px;
    padding: 20px;

    background:
        rgba(255, 255, 255, 0.07);

    border:
        1px solid
        rgba(255, 255, 255, 0.10);

    border-radius: 14px;
}

.feedback-block h3 {
    color: #93c5fd;
    margin-bottom: 12px;
    font-size: 19px;
}

.feedback-block p {
    color: #e5e7eb;
    line-height: 1.7;
}

.feedback-block ul {
    padding-left: 25px;
}

.feedback-block li {
    color: #e5e7eb;
    line-height: 1.6;
    margin-bottom: 9px;
}



/* =========================
   HISTORY CARD
========================= */

.history-card {
    background:
        rgba(255, 255, 255, 0.12);

    backdrop-filter: blur(18px);

    border:
        1px solid
        rgba(255, 255, 255, 0.15);

    border-radius: 20px;
    padding: 28px;
    margin-bottom: 25px;

    box-shadow:
        0 10px 25px
        rgba(0, 0, 0, 0.25);

    transition: 0.3s;
}

.history-card:hover {
    transform: translateY(-5px);

    background:
        rgba(255, 255, 255, 0.17);
}

.card-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 22px;
}

.topic {
    font-size: 24px;
    font-weight: bold;
    color: #00d4ff;
}

.score {
    background:
        rgba(0, 212, 255, 0.18);

    color: #67e8f9;

    padding: 9px 16px;
    border-radius: 20px;

    font-weight: bold;
}


/* =========================
   QUESTION / ANSWER / FEEDBACK
========================= */

.section {
    margin-top: 18px;
}

.section-title {
    font-weight: bold;
    color: #93c5fd;
    margin-bottom: 7px;
}

.section-content {
    color: #e5e7eb;
    line-height: 1.6;
    word-wrap: break-word;
}


/* =========================
   EMPTY HISTORY
========================= */

.empty-history {
    text-align: center;
    padding: 70px 20px;

    background:
        rgba(255, 255, 255, 0.10);

    border-radius: 20px;
}

.empty-history i {
    font-size: 65px;
    color: #00d4ff;
    margin-bottom: 20px;
}

.empty-history h2 {
    margin-bottom: 10px;
}

.empty-history p {
    color: #d1d5db;
}


/* =========================
   FOOTER
========================= */

.footer {
    text-align: center;
    color: #d1d5db;
    margin-top: 50px;
}


/* =========================
   MOBILE
========================= */

@media (max-width: 600px) {

    .navbar {
        padding: 18px 20px;
    }

    .logo {
        font-size: 21px;
    }

    .back-btn {
        padding: 10px 15px;
    }

    .container {
        width: 92%;
        padding-top: 35px;
    }

    .page-header h1 {
        font-size: 32px;
    }

    .page-header p {
        font-size: 16px;
    }

    .overall-score {
        width: 100%;
    }

    .overall-feedback {
        padding: 20px;
    }

    .card-top {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }
}

</style>

</head>


<body>


<!-- =========================
     NAVBAR
========================= -->

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


<!-- =========================
     MAIN CONTAINER
========================= -->

<div class="container">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <i class="fa-solid fa-clock-rotate-left"></i>

        <h1>
            Interview History
        </h1>

        <p>
            Review your previous interview attempts,
            scores and AI feedback.
        </p>

    </div>


    <% if (historyList != null &&
           !historyList.isEmpty()) { %>


        


        <!-- =========================
             STRUCTURED AI FEEDBACK
        ========================= -->

        <% if (overallFeedback != null) { %>

            <div class="overall-feedback">


                <h2>

                    <i class="fa-solid fa-robot"></i>

                    Overall AI Feedback

                </h2>


                <!-- PERFORMANCE SUMMARY -->

                <div class="feedback-block">

                    <h3>
                        📊 Performance Summary
                    </h3>

                    <p>

                        <%= overallFeedback
                                .getPerformanceSummary()
                        %>

                    </p>

                </div>


                <!-- STRENGTHS -->

                <div class="feedback-block">

                    <h3>
                        ✅ Strengths
                    </h3>

                    <ul>

                        <%
                            if (overallFeedback
                                    .getStrengths() != null
                                &&
                                !overallFeedback
                                    .getStrengths()
                                    .isEmpty()) {

                                for (String strength :
                                        overallFeedback
                                            .getStrengths()) {
                        %>

                            <li>
                                <%= strength %>
                            </li>

                        <%
                                }

                            } else {
                        %>

                            <li>
                                No specific strengths identified.
                            </li>

                        <%
                            }
                        %>

                    </ul>

                </div>


                <!-- WEAKNESSES -->

                <div class="feedback-block">

                    <h3>
                        ⚠️ Weaknesses
                    </h3>

                    <ul>

                        <%
                            if (overallFeedback
                                    .getWeaknesses() != null
                                &&
                                !overallFeedback
                                    .getWeaknesses()
                                    .isEmpty()) {

                                for (String weakness :
                                        overallFeedback
                                            .getWeaknesses()) {
                        %>

                            <li>
                                <%= weakness %>
                            </li>

                        <%
                                }

                            } else {
                        %>

                            <li>
                                No specific weaknesses identified.
                            </li>

                        <%
                            }
                        %>

                    </ul>

                </div>


                <!-- AREAS FOR IMPROVEMENT -->

                <div class="feedback-block">

                    <h3>
                        🎯 Areas for Improvement
                    </h3>

                    <ul>

                        <%
                            if (overallFeedback
                                    .getAreasForImprovement()
                                    != null
                                &&
                                !overallFeedback
                                    .getAreasForImprovement()
                                    .isEmpty()) {

                                for (String area :
                                        overallFeedback
                                            .getAreasForImprovement()) {
                        %>

                            <li>
                                <%= area %>
                            </li>

                        <%
                                }

                            } else {
                        %>

                            <li>
                                No specific improvement areas identified.
                            </li>

                        <%
                            }
                        %>

                    </ul>

                </div>


            </div>

        <% } %>


      


        <!-- =========================
             INTERVIEW HISTORY
        ========================= -->

        <% for (InterviewHistory history :
                historyList) { %>


            <div class="history-card">


                <!-- TOPIC + SCORE -->

                <div class="card-top">


                    <div class="topic">

                        <i class="fa-solid fa-book-open"></i>

                        <%= history.getTopic() %>

                    </div>


                    <div class="score">

                        Score:
                        <%= history.getScore() %>/10

                    </div>


                </div>


                <!-- QUESTION -->

                <div class="section">

                    <div class="section-title">

                        <i class="fa-solid fa-circle-question"></i>

                        Question

                    </div>

                    <div class="section-content">

                        <%= history.getQuestion() %>

                    </div>

                </div>


                <!-- USER ANSWER -->

                <div class="section">

                    <div class="section-title">

                        <i class="fa-solid fa-user"></i>

                        Your Answer

                    </div>

                    <div class="section-content">

                        <%= history.getUserAnswer() %>

                    </div>

                </div>


                <!-- AI FEEDBACK -->

                <div class="section">

                    <div class="section-title">

                        <i class="fa-solid fa-robot"></i>

                        AI Feedback

                    </div>

                    <div class="section-content">

                        <%
                            if (history.getFeedback() != null
                                &&
                                !history.getFeedback()
                                    .trim()
                                    .isEmpty()) {
                        %>

                            <%= history.getFeedback() %>

                        <% } else { %>

                            No feedback available.

                        <% } %>

                    </div>

                </div>


            </div>


        <% } %>


    <% } else { %>


        <!-- =========================
             NO HISTORY
        ========================= -->

        <div class="empty-history">

            <i class="fa-solid fa-folder-open"></i>

            <h2>
                No Interview History Yet
            </h2>

            <p>
                Complete an interview to see
                your results here.
            </p>

        </div>


    <% } %>


    <!-- FOOTER -->

    <div class="footer">

        AI Interview Portal © 2026

    </div>


</div>


</body>

</html>