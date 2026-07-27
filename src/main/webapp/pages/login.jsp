<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>AI Interview Portal | Login</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

</head>
<script>

function togglePassword(){

let pass=document.getElementById("password");

if(pass.type==="password"){

pass.type="text";

}else{

pass.type="password";

}

}

</script>

<body>

<div class="container">

<div class="glass-card">

<h1>Welcome Back</h1>

<p>Login to continue your AI Interview Journey</p>

<form action="${pageContext.request.contextPath}/LoginServlet"
method="post">

<div class="input-box">

<i class="fa-solid fa-envelope"></i>

<input
type="email"
name="email"
placeholder="Email Address"
required>

</div>

<div class="input-box">

<i class="fa-solid fa-lock"></i>

<input
type="password"
id="password"
name="password"
placeholder="Password"
required>

<span class="toggle-password"
onclick="togglePassword()">

<i class="fa-solid fa-eye"></i>

</span>

</div>

<button class="btn">

Login

</button>

</form>

<div class="bottom-text">

Don't have an account?

<a href="register.jsp">Register</a>

</div>

</div>

</div>

</body>
</html>