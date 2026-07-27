<%@ page import="com.aiportal.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html>

<head>

<title>Interview</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="glass-card">

<h1><%= request.getAttribute("topic") %> Interview</h1>

<p>

Welcome to the AI Interview Portal.

</p>

<p>

Questions will appear here.

</p>

</div>

</body>

</html>