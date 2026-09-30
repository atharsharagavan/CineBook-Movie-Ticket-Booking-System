<%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Document> bookings =
    (List<Document>) request.getAttribute("myBookings");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Bookings | CineBook</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

<style>
.booking-card {
    background: #1c1c1c;
    padding: 25px;
    margin: 20px auto;
    border-radius: 12px;
    max-width: 650px;
    color: white;
    border: 1px solid #333;
}

.booking-card p {
    margin: 10px 0;
}

.booking-status {
    color: #4ade80;
    font-weight: bold;
}

.empty-bookings {
    text-align: center;
    padding: 50px 20px;
}
</style>
</head>

<body>

<section class="movies-section">

    <h1>My Bookings</h1>

    <p>Your cinema experience, all in one place.</p>

    <%
    if (bookings == null || bookings.isEmpty()) {
    %>

        <div class="empty-bookings">
            <h2>No bookings yet!</h2>
            <p>Book your first movie and it will appear here.</p>
            <a href="${pageContext.request.contextPath}/index.jsp"
               class="hero-btn">Explore Movies</a>
        </div>

    <%
    } else {
        for (Document booking : bookings) {
    %>

        <div class="booking-card">

            <h2>Movie ID: <%= booking.getString("movieId") %></h2>

            <p>
                <strong>Date:</strong>
                <%= booking.getString("showDate") %>
            </p>

            <p>
                <strong>Show Time:</strong>
                <%= booking.getString("showTime") %>
            </p>

            <p>
                <strong>Seats:</strong>
                <%= booking.getInteger("seats") %>
            </p>

            <p>
                <strong>Total Amount:</strong>
                ₹<%= booking.getInteger("totalPrice") %>
            </p>

            <p class="booking-status">
                <%= booking.getString("status") %>
            </p>

        </div>

    <%
        }
    }
    %>

    <br>

    <a href="${pageContext.request.contextPath}/index.jsp"
       class="hero-btn">Back to Home</a>

</section>

</body>
</html>