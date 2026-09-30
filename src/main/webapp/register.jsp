<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Create Account | CineBook</title>

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
            <h1>Your seat<br>is waiting.</h1>
            <p>
                Discover stories, find your favourite films,
                and make every movie night memorable.
            </p>
        </div>

        <p style="color:#888;font-size:12px;">
            YOUR CINEMA. YOUR MOMENT.
        </p>

    </div>

    <div class="auth-form-panel">

        <form class="auth-form"
              action="${pageContext.request.contextPath}/register"
              method="post">

            <h2>Join CineBook.</h2>

            <p class="auth-subtitle">
                Create your account and let the stories begin.
            </p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="auth-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <label for="name">Full Name</label>

            <input type="text"
                   id="name"
                   name="name"
                   placeholder="Your name"
                   autocomplete="name"
                   required>

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
                   placeholder="Minimum 8 characters"
                   minlength="8"
                   autocomplete="new-password"
                   required>

            <label for="confirmPassword">Confirm Password</label>

            <input type="password"
                   id="confirmPassword"
                   name="confirmPassword"
                   placeholder="Re-enter your password"
                   minlength="8"
                   autocomplete="new-password"
                   required>

            <button type="submit" class="auth-button">
                Create Account →
            </button>

            <p class="auth-switch">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login.jsp">
                    Sign in
                </a>
            </p>

        </form>

    </div>

</div>

</body>
</html>