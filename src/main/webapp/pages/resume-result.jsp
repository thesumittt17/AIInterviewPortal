<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Resume Analysis</title>

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

background:linear-gradient(135deg,#2563eb,#0f172a);

min-height:100vh;

padding:40px;

color:white;

}

.container{

width:95%;

max-width:1300px;

margin:auto;

}

.title{

text-align:center;

font-size:42px;

font-weight:bold;

margin-bottom:40px;

}

.score-container{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(280px,1fr));

gap:25px;

margin-bottom:35px;

}

.score-card{

background:rgba(255,255,255,.12);

backdrop-filter:blur(20px);

padding:35px;

border-radius:25px;

text-align:center;

box-shadow:0 15px 40px rgba(0,0,0,.3);

transition:.3s;

}

.score-card:hover{

transform:translateY(-8px);

}

.score-card i{

font-size:50px;

margin-bottom:15px;

color:#00d4ff;

}

.score-card h3{

font-size:22px;

margin-bottom:10px;

}

.score{

font-size:55px;

font-weight:bold;

}

.cards{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(500px,1fr));

gap:25px;

}

.card{

background:rgba(255,255,255,.12);

backdrop-filter:blur(18px);

padding:30px;

border-radius:25px;

box-shadow:0 15px 40px rgba(0,0,0,.25);

}

.card h2{

margin-bottom:20px;

font-size:28px;

}

.card ul{

padding-left:25px;

}

.card li{

margin-bottom:12px;

font-size:18px;

}

.strength{

border-left:8px solid #22c55e;

}

.weakness{

border-left:8px solid #ef4444;

}

.skills{

border-left:8px solid orange;

}

.suggestion{

border-left:8px solid #3b82f6;

}

.topics{

margin-top:35px;

background:rgba(255,255,255,.12);

padding:30px;

border-radius:25px;

}

.badge{

display:inline-block;

background:#2563eb;

padding:12px 20px;

border-radius:25px;

margin:10px;

font-size:18px;

}

.buttons{

text-align:center;

margin-top:40px;

}

.btn{

display:inline-block;

padding:16px 30px;

margin:10px;

border-radius:30px;

text-decoration:none;

font-weight:bold;

transition:.3s;

}

.home{

background:#2563eb;

color:white;

}

.download{

background:#10b981;

color:white;

}

.btn:hover{

transform:scale(1.05);

}

</style>

</head>

<body>

<div class="container">

<div class="title">

🤖 AI Resume Analysis Report

</div>

<div class="score-container">

<div class="score-card">

<i class="fa-solid fa-file-lines"></i>

<h3>Resume Score</h3>

<div class="score">

${analysis.resumeScore}%

</div>

</div>

<div class="score-card">

<i class="fa-solid fa-bullseye"></i>

<h3>ATS Score</h3>

<div class="score">

${analysis.atsScore}%

</div>

</div>

</div>

<div class="cards">

<div class="card strength">

<h2>

<i class="fa-solid fa-circle-check"></i>

Strengths

</h2>

<ul>

<c:forEach items="${analysis.strengths}" var="s">

<li>${s}</li>

</c:forEach>

</ul>

</div>

<div class="card weakness">

<h2>

<i class="fa-solid fa-circle-xmark"></i>

Weaknesses

</h2>

<ul>

<c:forEach items="${analysis.weaknesses}" var="s">

<li>${s}</li>

</c:forEach>

</ul>

</div>

<div class="card skills">

<h2>

<i class="fa-solid fa-code"></i>

Missing Skills

</h2>

<ul>

<c:forEach items="${analysis.missingSkills}" var="s">

<li>${s}</li>

</c:forEach>

</ul>

</div>

<div class="card suggestion">

<h2>

<i class="fa-solid fa-lightbulb"></i>

AI Suggestions

</h2>

<ul>

<c:forEach items="${analysis.suggestions}" var="s">

<li>${s}</li>

</c:forEach>

</ul>

</div>

</div>

<div class="topics">

<h2>

<i class="fa-solid fa-book-open"></i>

Recommended Interview Topics

</h2>

<br><br>

<c:forEach items="${analysis.recommendedTopics}" var="t">

<span class="badge">

${t}

</span>

</c:forEach>

</div>

<div class="buttons">

<a class="btn home"

href="${pageContext.request.contextPath}/dashboard">

<i class="fa-solid fa-house"></i>

Dashboard

</a>


</div>

</div>

</body>

</html>