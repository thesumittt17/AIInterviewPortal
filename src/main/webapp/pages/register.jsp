<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String status = (String) request.getAttribute("status");
String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>AI Interview Portal | Register</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

</head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<body>

<div class="container">

<div class="glass-card">

<h1>AI Interview Portal</h1>

<p>Create your account</p>



<form action="${pageContext.request.contextPath}/RegisterServlet"
method="post">

<div class="input-box">

<i class="fa-solid fa-user"></i>

<input
type="text"
name="name"
placeholder="Full Name"
required>

</div>

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
name="password"
placeholder="Password"
required>

</div>

<button class="btn">

Create Account

</button>

</form>

<div class="bottom-text">

Already have an account?

<a href="login.jsp">Login</a>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<% if(status != null){ %>

<script>

Swal.fire({
    icon: "<%= status.equals("success") ? "success" : "error" %>",
    title: "<%= message %>",
    confirmButtonColor: "#3085d6",
    confirmButtonText: "OK"
});

</script>

<% } %>
</body>
</html>