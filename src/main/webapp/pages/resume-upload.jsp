<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

<title>Resume Analyzer</title>

<style>

body{

font-family:Segoe UI;

background:#0f172a;

color:white;

display:flex;

justify-content:center;

align-items:center;

height:100vh;

}

.container{

background:#1e293b;

padding:40px;

border-radius:20px;

width:500px;

text-align:center;

}

input{

margin:20px;

}

button{

padding:15px 25px;

background:#2563eb;

border:none;

color:white;

border-radius:10px;

cursor:pointer;

font-size:16px;

}

button:hover{

background:#1d4ed8;

}

</style>

</head>

<body>

<div class="container">

<h1>AI Resume Analyzer</h1>

<form

action="${pageContext.request.contextPath}/upload-resume"

method="post"

enctype="multipart/form-data">

<input

type="file"

name="resume"

accept=".pdf"

required>

<br>

<button type="submit">

Analyze Resume

</button>

</form>

</div>

</body>

</html>