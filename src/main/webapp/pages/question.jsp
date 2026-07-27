<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>AI Interview | ${topic}</title>

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
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 60px;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
        }

        .logo {
            font-size: 27px;
            font-weight: 700;
        }

        .back-btn {
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 10px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: rgba(255,255,255,0.15);
        }

        /* MAIN CONTAINER */

        .container {
            width: 90%;
            max-width: 900px;
            margin: 50px auto;
        }

        /* TOP SECTION */

        .top-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .topic-badge {
            display: inline-block;
            background: rgba(0, 212, 255, 0.15);
            color: #00d4ff;
            padding: 9px 20px;
            border-radius: 30px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .top-section h1 {
            font-size: 34px;
            margin-bottom: 8px;
        }

        .top-section p {
            color: #cbd5e1;
            font-size: 16px;
        }

        /* INTERVIEW CARD */

        .interview-card {
            background: rgba(255,255,255,0.11);
            backdrop-filter: blur(18px);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 22px;
            padding: 35px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        /* QUESTION HEADER */

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 22px;
        }

        .question-number {
            color: #00d4ff;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        /* TIMER */

        .timer-box {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 10px 18px;
            border-radius: 12px;
            background: rgba(15, 23, 42, 0.65);
            border: 1px solid rgba(0, 212, 255, 0.4);
            color: #00d4ff;
            font-size: 20px;
            font-weight: 700;
            min-width: 105px;
            justify-content: center;
        }

        .timer-warning {
            color: #ff4b5c;
            border-color: rgba(255, 75, 92, 0.6);
            animation: pulse 0.8s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }

            50% {
                opacity: 0.45;
            }
        }

        /* QUESTION */

        .question {
            font-size: 24px;
            line-height: 1.5;
            margin-bottom: 30px;
            padding: 22px;
            background: rgba(15, 23, 42, 0.45);
            border-left: 4px solid #00d4ff;
            border-radius: 12px;
        }

        /* ANSWER */

        .answer-label {
            display: block;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .answer-label i {
            color: #00d4ff;
            margin-right: 7px;
        }

        textarea {
            width: 100%;
            min-height: 180px;
            resize: vertical;
            padding: 18px;
            font-size: 16px;
            line-height: 1.6;
            color: white;
            background: rgba(15, 23, 42, 0.65);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 14px;
            outline: none;
            transition: 0.3s;
        }

        textarea::placeholder {
            color: #94a3b8;
        }

        textarea:focus {
            border-color: #00d4ff;
            box-shadow: 0 0 0 3px rgba(0,212,255,0.12);
        }

        /* BOTTOM SECTION */

        .bottom-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-top: 25px;
        }

        .time-info {
            color: #94a3b8;
            font-size: 14px;
        }

        .time-info i {
            margin-right: 6px;
        }

        /* SUBMIT BUTTON */

        .submit-btn {
            border: none;
            cursor: pointer;
            padding: 14px 28px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
            background: #00d4ff;
            transition: 0.3s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,212,255,0.3);
        }

        .submit-btn i {
            margin-left: 8px;
        }

        .submit-btn:disabled {
            cursor: not-allowed;
            opacity: 0.7;
            transform: none;
        }

        /* MOBILE */

        @media(max-width: 600px) {

            .navbar {
                padding: 18px 20px;
            }

            .logo {
                font-size: 20px;
            }

            .back-btn {
                padding: 9px 13px;
                font-size: 14px;
            }

            .container {
                margin: 30px auto;
            }

            .interview-card {
                padding: 25px 20px;
            }

            .top-section h1 {
                font-size: 28px;
            }

            .question {
                font-size: 20px;
            }

            .question-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .bottom-section {
                flex-direction: column;
                align-items: stretch;
            }

            .submit-btn {
                width: 100%;
            }
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

    <a class="back-btn"
       href="${pageContext.request.contextPath}/pages/dashboard.jsp">

        <i class="fa-solid fa-arrow-left"></i>
        Dashboard

    </a>

</nav>


<!-- MAIN CONTENT -->

<main class="container">


    <!-- TOP SECTION -->

    <div class="top-section">

        <div class="topic-badge">
            <i class="fa-solid fa-code"></i>
            ${topic} Interview
        </div>

        <h1>AI Interview Session</h1>

        <p>
            Answer the question clearly before the timer reaches zero.
        </p>

    </div>


    <!-- INTERVIEW CARD -->

    <div class="interview-card">


        <!-- QUESTION NUMBER + TIMER -->

        <div class="question-header">

            <div class="question-number">
                QUESTION 01
            </div>

            <div class="timer-box" id="timerBox">

                <i class="fa-solid fa-clock"></i>

                <span id="timer">
                    01:00
                </span>

            </div>

        </div>


        <!-- AI GENERATED QUESTION -->

        <div class="question">
            ${question}
        </div>


        <!-- ANSWER FORM -->

        <form id="answerForm"
              action="${pageContext.request.contextPath}/evaluate-answer"
              method="post">


            <!-- HIDDEN TOPIC -->

            <input type="hidden"
                   name="topic"
                   value="${topic}">


            <!-- HIDDEN QUESTION -->

            <input type="hidden"
                   name="question"
                   value="${question}">


            <!-- ANSWER -->

            <label class="answer-label"
                   for="answer">

                <i class="fa-solid fa-pen"></i>
                Your Answer

            </label>


            <textarea
                id="answer"
                name="answer"
                placeholder="Type your answer here..."
                required></textarea>


            <!-- BOTTOM SECTION -->

            <div class="bottom-section">

                <div class="time-info">
                    <i class="fa-solid fa-circle-info"></i>
                    Your answer will be submitted automatically when time runs out.
                </div>


                <button class="submit-btn"
                        id="submitButton"
                        type="submit">

                    Submit Answer

                    <i class="fa-solid fa-arrow-right"></i>

                </button>

            </div>

        </form>

    </div>

</main>


<!-- TIMER SCRIPT -->

<script>

    let timeLeft = 60;
    let formSubmitted = false;

    const timer = document.getElementById("timer");
    const timerBox = document.getElementById("timerBox");
    const answerForm = document.getElementById("answerForm");
    const submitButton = document.getElementById("submitButton");


    const countdown = setInterval(function () {

        timeLeft--;


        // DISPLAY TIMER

        const seconds =
                timeLeft < 10
                ? "0" + timeLeft
                : timeLeft;

        timer.textContent = "00:" + seconds;


        // LAST 10 SECONDS WARNING

        if (timeLeft <= 10) {

            timerBox.classList.add("timer-warning");

        }


        // TIME FINISHED

        if (timeLeft <= 0) {

            clearInterval(countdown);

            timer.textContent = "00:00";

            if (!formSubmitted) {

                formSubmitted = true;

                submitButton.disabled = true;

                submitButton.innerHTML =
                        'Evaluating... <i class="fa-solid fa-spinner fa-spin"></i>';

                /*
                 * form.submit() intentionally bypasses
                 * the HTML "required" validation.
                 *
                 * This allows an empty answer to be sent
                 * automatically when the timer reaches zero.
                 */

                answerForm.submit();

            }

        }

    }, 1000);


    // MANUAL SUBMISSION

    answerForm.addEventListener("submit", function () {

        if (!formSubmitted) {

            formSubmitted = true;

            clearInterval(countdown);

            submitButton.disabled = true;

            submitButton.innerHTML =
                    'Evaluating... <i class="fa-solid fa-spinner fa-spin"></i>';

        }

    });

</script>


</body>
</html>