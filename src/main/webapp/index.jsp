<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CineBook | Your Movie Destination</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

    <nav class="navbar">

        <a href="${pageContext.request.contextPath}/index.jsp"
           class="logo">CINE<span>BOOK</span></a>

        <div class="nav-links">

            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="#movies">Movies</a>

            <% if (session.getAttribute("userId") != null) { %>

                <span>
                    Hi, <%= session.getAttribute("userName") %>
                </span>

                <a href="${pageContext.request.contextPath}/logout"
                   class="nav-btn">Logout</a>
                   <a href="${pageContext.request.contextPath}/my-bookings"
   class="hero-btn">
   My Bookings
</a>

            <% } else { %>

                <a href="${pageContext.request.contextPath}/login.jsp">Login</a>

                <a href="${pageContext.request.contextPath}/register.jsp"
                   class="nav-btn">Sign Up</a>

            <% } %>

        </div>
    </nav>

    <section class="hero">
        <div class="hero-content">

            <span class="tag">YOUR CINEMA EXPERIENCE</span>

            <h1>
                Every Story<br>
                Deserves a <span>Big Screen.</span>
            </h1>

            <p>
                Discover movies, explore stories, and book your
                next unforgettable cinema experience.
            </p>

            <a href="#movies" class="hero-btn">Explore Movies →</a>

        </div>
    </section>

    <section class="movies-section" id="movies">

        <div class="section-heading">
            <div>
                <span class="tag">NOW SHOWING</span>
                <h2>Featured Movies</h2>
            </div>
        </div>

        <div id="movie-container" class="movie-grid">
            <p>Loading movies...</p>
        </div>

    <footer>
        <h2 class="logo">CINE<span>BOOK</span></h2>
        <p>Made for the love of cinema.</p>
        <p>© 2026 CineBook. All rights reserved.</p>
    </footer></section>

    

    <script src="${pageContext.request.contextPath}/js/movies.js"></script>

</body>
</html>