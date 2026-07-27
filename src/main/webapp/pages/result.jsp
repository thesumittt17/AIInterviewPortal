<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Interview Result | AI Interview Portal</title>

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

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 60px;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
        }

        .logo {
            font-size: 27px;
            font-weight: bold;
        }

        .dashboard-btn {
            color: white;
            text-decoration: none;
            padding: 11px 18px;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 10px;
            transition: 0.3s;
        }

        .dashboard-btn:hover {
            background: rgba(255,255,255,0.15);
        }

        .container {
            width: 90%;
            max-width: 950px;
            margin: 45px auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .success-icon {
            width: 75px;
            height: 75px;
            margin: 0 auto 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
            background: rgba(34, 197, 94, 0.18);
            color: #4ade80;
            font-size: 34px;
        }

        .page-header h1 {
            font-size: 35px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #cbd5e1;
            font-size: 17px;
        }

        .topic-badge {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 18px;
            border-radius: 30px;
            background: rgba(0, 212, 255, 0.15);
            color: #00d4ff;
            font-weight: 600;
        }

        .result-card {
            background: rgba(255, 255, 255, 0.11);
            backdrop-filter: blur(18px);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 22px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.25);
        }

        .card-title {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #00d4ff;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .content {
            background: rgba(15, 23, 42, 0.55);
            border-radius: 12px;
            padding: 20px;
            line-height: 1.7;
            font-size: 17px;
            color: #e2e8f0;
        }

        /* SCORE */

        .score-card {
            text-align: center;
        }

        .score-circle {
            width: 140px;
            height: 140px;
            margin: 10px auto;
            border-radius: 50%;
            border: 8px solid #00d4ff;

            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            background: rgba(15, 23, 42, 0.65);
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.25);
        }

        .score-number {
            font-size: 42px;
            font-weight: bold;
            color: #00d4ff;
        }

        .score-total {
            color: #cbd5e1;
            font-size: 16px;
        }

        /* MISSING POINTS */

        .missing-list {
            list-style: none;
        }

        .missing-list li {
            padding: 10px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            line-height: 1.6;
        }

        .missing-list li:last-child {
            border-bottom: none;
        }

        .missing-list i {
            color: #fbbf24;
            margin-right: 10px;
        }

        /* BETTER ANSWER */

        .better-answer {
            border-left: 4px solid #4ade80;
        }

        /* BUTTONS */

        .actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 13px 23px;
            border-radius: 11px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .primary-btn {
            background: #00d4ff;
            color: #0f172a;
        }

        .secondary-btn {
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
        }

        .btn:hover {
            transform: translateY(-3px);
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 18px 20px;
            }

            .logo {
                font-size: 20px;
            }

            .dashboard-btn {
                padding: 9px 13px;
                font-size: 14px;
            }

            .result-card {
                padding: 22px;
            }

            .page-header h1 {
                font-size: 28px;
            }

            .score-circle {
                width: 120px;
                height: 120px;
            }
        }
        
        .badge{

display:inline-block;

padding:6px 14px;

border-radius:20px;

font-weight:600;

margin-left:8px;

}

.difficulty{

background:#f59e0b;

color:white;

}

.confidence{

background:#2563eb;

color:white;

}

    </style>
</head>

<body>

<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">
        <i class="fa-solid fa-brain"></i>
        AI Interview Portal
    </div>

    <a class="dashboard-btn"
      href="${pageContext.request.contextPath}/dashboard">

        <i class="fa-solid fa-house"></i>
        Dashboard

    </a>

</nav>


<main class="container">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <div class="success-icon">
            <i class="fa-solid fa-check"></i>
        </div>

        <h1>AI Interview Evaluation</h1>

        <p>
            Your answer has been evaluated by AI.
        </p>

        <div class="topic-badge">
            <i class="fa-solid fa-code"></i>
            ${topic}
        </div>

    </div>


    <!-- QUESTION -->

    <div class="result-card">

        <div class="card-title">
            <i class="fa-solid fa-circle-question"></i>
            Interview Question
        </div>

        <div class="content">
            ${question}
        </div>

    </div>


    <!-- USER ANSWER -->

    <div class="result-card">

        <div class="card-title">
            <i class="fa-solid fa-pen-to-square"></i>
            Your Answer
        </div>

        <div class="content">
            ${answer}
        </div>

    </div>


    <!-- AI SCORE -->

    <div class="result-card score-card">

        <div class="card-title">
            <i class="fa-solid fa-star"></i>
            AI Score
        </div>

        <div class="score-circle">

           <div class="score-number">
    ${score}
</div>

<div class="score-total">
    out of 100
</div>

        </div>
            
    </div>
            
            <!-- AI ANALYSIS -->

<!-- AI ANALYSIS -->

<div class="result-card">

    <div class="card-title">
        <i class="fa-solid fa-chart-simple"></i>
        AI Analysis
    </div>

    <div class="content">

        <p>
            <strong>Difficulty:</strong>
            <span class="badge difficulty">${difficulty}</span>
        </p>

        <br>

        <p>
            <strong>AI Confidence:</strong>
            <span class="badge confidence">${confidence}</span>
        </p>

        <br>

        <h3>Strengths</h3>

        <ul class="missing-list">

            <c:choose>

                <c:when test="${not empty strengths}">

                    <c:forEach items="${strengths}" var="item">

                        <li>
                            <i class="fa-solid fa-circle-check"
                               style="color:#22c55e;"></i>
                            ${item}
                        </li>

                    </c:forEach>

                </c:when>

                <c:otherwise>

                    <li>No strengths identified.</li>

                </c:otherwise>

            </c:choose>

        </ul>

        <br>

        <h3>Weaknesses</h3>

        <ul class="missing-list">

            <c:choose>

                <c:when test="${not empty weaknesses}">

                    <c:forEach items="${weaknesses}" var="item">

                        <li>
                            <i class="fa-solid fa-circle-xmark"
                               style="color:#ef4444;"></i>
                            ${item}
                        </li>

                    </c:forEach>

                </c:when>

                <c:otherwise>

                    <li>No weaknesses identified.</li>

                </c:otherwise>

            </c:choose>

        </ul>

    </div>

</div>            
            

    <!-- AI FEEDBACK -->

    <div class="result-card">

        <div class="card-title">
            <i class="fa-solid fa-robot"></i>
            AI Feedback
        </div>

        <div class="content">
            ${feedback}
        </div>

    </div>


    <!-- MISSING POINTS -->

    <div class="result-card">

        <div class="card-title">
            <i class="fa-solid fa-list-check"></i>
            Missing Points
        </div>

        <div class="content">

            <ul class="missing-list">

                <%
                    List<String> missingPoints =
                            (List<String>) request.getAttribute("missingPoints");

                    if (missingPoints != null && !missingPoints.isEmpty()) {

                        for (String point : missingPoints) {
                %>

                <li>
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <%= point %>
                </li>

                <%
                        }

                    } else {
                %>

                <li>
                    <i class="fa-solid fa-check"></i>
                    No major points were missed.
                </li>

                <%
                    }
                %>

            </ul>

        </div>

    </div>


    <!-- BETTER ANSWER -->

    <div class="result-card">

        <div class="card-title">
            <i class="fa-solid fa-lightbulb"></i>
            Better Interview Answer
        </div>

        <div class="content better-answer">
            ${betterAnswer}
        </div>

    </div>


    <!-- ACTION BUTTONS -->

    <div class="actions">

        <a class="btn primary-btn"
           href="${pageContext.request.contextPath}/generate-question?topic=${topic}">

            <i class="fa-solid fa-arrow-rotate-right"></i>
            Next Question

        </a>


        <a class="btn secondary-btn"
           href="${pageContext.request.contextPath}/dashboard">

            <i class="fa-solid fa-table-columns"></i>
            Choose Another Topic

        </a>

    </div>


</main>

</body>
</html>