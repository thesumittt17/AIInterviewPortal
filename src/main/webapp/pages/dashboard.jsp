<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core"%>


<c:if test="${empty sessionScope.user}">
    <c:redirect url="/pages/login.jsp"/>
</c:if>


<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>AI Interview Portal | Dashboard</title>


<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


<style>


*{

margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;

}



body{


min-height:100vh;

background:
radial-gradient(circle at top,#2563eb,#020617 70%);

color:white;

}



/* NAVBAR */


.navbar{


width:90%;

margin:25px auto;

padding:18px 30px;

display:flex;

justify-content:space-between;

align-items:center;


background:rgba(255,255,255,0.12);

backdrop-filter:blur(20px);

border-radius:20px;


}



.logo{

font-size:28px;

font-weight:700;

}



.nav-links{


display:flex;

gap:15px;

align-items:center;

}



.nav-btn{


padding:12px 20px;

border-radius:12px;

text-decoration:none;

color:white;

font-weight:600;

transition:.3s;


}



.history{

background:#4f46e5;

}



.performance{

background:#0891b2;

}



.logout{

background:#ef4444;

}



.nav-btn:hover{


transform:translateY(-3px);

}




.profile{


display:flex;

align-items:center;

gap:10px;


background:rgba(255,255,255,.15);

padding:10px 18px;

border-radius:20px;


}



/* MAIN */


.container{


width:90%;

margin:auto;


}



/* HERO */


.hero{


margin-top:40px;

padding:50px;

border-radius:30px;


background:
linear-gradient(
135deg,
#2563eb,
#7c3aed
);


text-align:center;


box-shadow:
0 20px 50px rgba(0,0,0,.3);


}



.hero h1{


font-size:45px;


}



.hero p{


margin-top:15px;

font-size:20px;

color:#ddd;


}



.start-btn{


display:inline-block;

margin-top:30px;

padding:15px 35px;


background:white;

color:#2563eb;


border-radius:30px;

text-decoration:none;

font-weight:bold;

font-size:18px;

transition:.3s;


}



.start-btn:hover{


transform:scale(1.05);


}





/* STATS */


.stats{


display:grid;

grid-template-columns:
repeat(auto-fit,minmax(250px,1fr));


gap:25px;

margin:50px 0;


}



.stat-card{


background:
rgba(255,255,255,.12);


backdrop-filter:blur(20px);


padding:35px;


border-radius:25px;


text-align:center;


box-shadow:
0 15px 35px rgba(0,0,0,.25);


transition:.3s;


}



.stat-card:hover{


transform:translateY(-8px);


}



.stat-card i{


font-size:40px;

color:#00d4ff;

margin-bottom:20px;


}



.stat-card h2{


font-size:38px;

}



.stat-card p{


color:#ddd;

margin-top:10px;


}




/* TOPIC */


.heading{


text-align:center;

font-size:34px;

margin-bottom:35px;


}



.grid{


display:grid;


grid-template-columns:
repeat(auto-fit,minmax(220px,1fr));


gap:30px;


}




.card{


padding:40px;


text-align:center;


background:
rgba(255,255,255,.12);


backdrop-filter:blur(18px);


border-radius:25px;


text-decoration:none;


color:white;


transition:.35s;


}



.card:hover{


transform:
translateY(-10px)
scale(1.04);


background:
rgba(255,255,255,.2);


}




.card i{


font-size:55px;

color:#00d4ff;

margin-bottom:20px;


}



.card h3{


font-size:25px;


}




.footer{


text-align:center;

padding:40px;

color:#ccc;


}




@media(max-width:800px){


.navbar{


flex-direction:column;

gap:20px;


}



.nav-links{


flex-wrap:wrap;

justify-content:center;


}



.hero h1{


font-size:32px;


}


}

canvas{
    height:320px !important;
}

.stat-card canvas{
    width:100% !important;
    height:320px !important;
}


</style>


</head>



<body>




<!-- NAVBAR -->


<div class="navbar">


<div class="logo">

🤖 AI Interview Portal

</div>



<div class="nav-links">



<div class="profile">

<i class="fa-solid fa-user"></i>

${sessionScope.user.name}

</div>



<a class="nav-btn history"
href="${pageContext.request.contextPath}/history">

<i class="fa-solid fa-clock"></i>
History

</a>



<a class="nav-btn performance"
href="${pageContext.request.contextPath}/overall-feedback">


<i class="fa-solid fa-chart-line"></i>

Performance

</a>

<a class="nav-btn performance"
href="${pageContext.request.contextPath}/pages/resume-upload.jsp">

<i class="fa-solid fa-file"></i>

Resume Analyzer

</a>

<a class="nav-btn logout"
href="${pageContext.request.contextPath}/LogoutServlet">
<i class="fa-solid fa-right-from-bracket"></i>
Logout
</a>
</div>
</div>
<div class="container">





<!-- HERO -->


<div class="hero">

<h1>
Welcome back, ${sessionScope.user.name} 👋
</h1>

<p>
Practice interviews, improve your technical skills, and track your progress with AI-powered analytics.
</p>

<a class="start-btn"
href="#topics"
<i class="fa-solid fa-play"></i>
Start Interview
</a>
</div>


<!-- STATISTICS -->


<!-- DASHBOARD STATISTICS -->

<div class="stats">

    <div class="stat-card">
        <i class="fa-solid fa-file-lines"></i>
        <h2>${sessionScope.totalInterviews}</h2>
        <p>Total Interviews</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-chart-simple"></i>
        <h2>${sessionScope.averageScore}%</h2>
        <p>Average Performance</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-trophy"></i>
        <h2>${sessionScope.highestScore}%</h2>
        <p>Best Interview</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-arrow-trend-down"></i>
        <h2>${sessionScope.lowestScore}%</h2>
        <p>Needs Improvement</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-medal"></i>
        <h2>${sessionScope.bestTopic}</h2>
        <p>Best Topic</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-book-open"></i>
        <h2>${sessionScope.weakestTopic}</h2>
        <p>Weakest Topic</p>
    </div>

</div>
        
        
        
        <!-- ANALYTICS -->

<h2 class="heading">
📊 Interview Analytics
</h2>

<div class="stats">

    <div class="stat-card">
        <i class="fa-solid fa-brain"></i>
        <h2>${sessionScope.bestTopic}</h2>
        <p>Strongest Subject</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-book"></i>
        <h2>${sessionScope.weakestTopic}</h2>
        <p>Needs Improvement</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-chart-line"></i>
        <h2>${sessionScope.averageScore}%</h2>
        <p>Overall Performance</p>
    </div>

</div>

        
        <h2 class="heading">📈 Performance Charts</h2>

<div class="stats">

    <div class="stat-card">
        <canvas id="scoreChart"></canvas>
    </div>

    <div class="stat-card">
        <canvas id="topicChart"></canvas>
    </div>

</div>
 
 <div id="topics"></div>
<h2 class="heading">

Choose Interview Topic

</h2>

<div class="grid">

<a class="card"
href="${pageContext.request.contextPath}/generate-question?topic=Java">


<i class="fa-brands fa-java"></i>

<h3>Java</h3>


</a>

<a class="card"
href="${pageContext.request.contextPath}/generate-question?topic=SQL">


<i class="fa-solid fa-database"></i>

<h3>SQL</h3>


</a>

<a class="card"
href="${pageContext.request.contextPath}/generate-question?topic=DBMS">


<i class="fa-solid fa-server"></i>

<h3>DBMS</h3>


</a>

<a class="card"
href="${pageContext.request.contextPath}/generate-question?topic=OOPS">


<i class="fa-solid fa-cubes"></i>

<h3>OOPS</h3>

</a>

<a class="card"
href="${pageContext.request.contextPath}/generate-question?topic=Operating%20System">


<i class="fa-solid fa-desktop"></i>

<h3>Operating System</h3>


</a>

<a class="card"
href="${pageContext.request.contextPath}/generate-question?topic=Computer%20Networks">


<i class="fa-solid fa-network-wired"></i>

<h3>Computer Networks</h3>
</a>

</div>
<div class="footer">

AI Interview Portal © 2026

</div>

</div>

<script>

// Topic Wise Average Data
const topicLabels = [
<c:forEach items="${topicAverage}" var="entry" varStatus="status">
'${entry.key}'<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const topicScores = [
<c:forEach items="${topicAverage}" var="entry" varStatus="status">
${entry.value}<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

// Interview Score History
const scoreData = [
<c:forEach items="${scoreHistory}" var="score" varStatus="status">
${score}<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

// Debugging (remove later if you want)
console.log("Topic Labels:", topicLabels);
console.log("Topic Scores:", topicScores);
console.log("Score History:", scoreData);

// Show message if no interview data exists
if (scoreData.length === 0) {
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("scoreChart").parentElement.innerHTML =
            "<h3 style='text-align:center;color:white;'>No Interview Data Available</h3>";
    });
}

// Show message if no topic analytics exist
if (topicLabels.length === 0) {
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("topicChart").parentElement.innerHTML =
            "<h3 style='text-align:center;color:white;'>No Topic Analytics Available</h3>";
    });
}

</script>
<script>

// ============================
// LINE CHART
// ============================

const scoreChart = document.getElementById('scoreChart');

new Chart(scoreChart, {
    type: 'line',
    data: {
        labels: scoreData.map((_, i) => "Interview " + (i + 1)),
        datasets: [{
            label: 'Interview Score',
            data: scoreData,
            borderColor: '#00d4ff',
            backgroundColor: 'rgba(0,212,255,0.2)',
            fill: true,
            borderWidth: 3,
            pointRadius: 5,
            pointHoverRadius: 8,
            tension: 0.35
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                labels: {
                    color: '#ffffff'
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: '#ffffff'
                }
            },
            y: {
                beginAtZero: true,
                max: 100,
                ticks: {
                    color: '#ffffff'
                }
            }
        }
    }
});


// ============================
// BAR CHART
// ============================

const topicChart = document.getElementById('topicChart');

new Chart(topicChart, {
    type: 'bar',
    data: {
        labels: topicLabels,
        datasets: [{
            label: 'Average Score',
            data: topicScores,
            backgroundColor: [
                '#2563eb',
                '#10b981',
                '#f59e0b',
                '#ef4444',
                '#8b5cf6',
                '#06b6d4'
            ],
            borderColor: '#ffffff',
            borderWidth: 1,
            borderRadius: 8
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                labels: {
                    color: '#ffffff'
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: '#ffffff'
                }
            },
            y: {
                beginAtZero: true,
                max: 100,
                ticks: {
                    color: '#ffffff'
                }
            }
        }
    }
});

</script>

</body>

</html>