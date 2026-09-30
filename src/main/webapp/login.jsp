<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | CineBook</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/auth.css">
</head>

<body class="auth-body">

<div class="auth-container">

    <div class="auth-visual">

        <div class="auth-brand">
            CINE<span>BOOK</span>
        </div>

        <div class="auth-tagline">
            <h1>Every story<br>deserves a<br>big screen.</h1>
            <p>
                Your next unforgettable movie experience
                begins with a single click.
            </p>
        </div>

        <p style="color:#888;font-size:12px;">
            YOUR CINEMA. YOUR MOMENT.
        </p>

    </div>

    <div class="auth-form-panel">

        <form class="auth-form"
              action="${pageContext.request.contextPath}/login"
              method="post">

            <h2>Welcome back.</h2>

            <p class="auth-subtitle">
                Sign in to continue your cinematic journey.
            </p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="auth-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <label for="email">Email Address</label>

            <input type="email"
                   id="email"
                   name="email"
                   placeholder="you@example.com"
                   autocomplete="email"
                   required>

            <label for="password">Password</label>

            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Enter your password"
                   autocomplete="current-password"
                   required>

            <button type="submit" class="auth-button">
                Sign In →
            </button>

            <p class="auth-switch">
                New to CineBook?
                <a href="${pageContext.request.contextPath}/register.jsp">
                    Create an account
                </a>
            </p>

        </form>

    </div>

</div>

</body>
</html>