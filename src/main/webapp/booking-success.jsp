<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Booking Confirmed | CineBook</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/auth.css">

<style>
.success-body {
    min-height: 100vh;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 25px;
    background:
        radial-gradient(circle at 50% 0%, #40121d, transparent 50%),
        #090909;
    color: white;
    font-family: 'DM Sans', sans-serif;
}

.ticket {
    width: 100%;
    max-width: 560px;
    background: #151313;
    border: 1px solid #38252a;
    border-radius: 22px;
    overflow: hidden;
    box-shadow: 0 25px 80px rgba(0,0,0,.55);
}

.ticket-header {
    text-align: center;
    padding: 40px 25px 30px;
    background: linear-gradient(135deg, #571522, #241014);
}

.success-icon {
    width: 75px;
    height: 75px;
    margin: 0 auto 20px;
    border-radius: 50%;
    background: rgba(255,255,255,.1);
    border: 2px solid #f05b70;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ff7387;
    font-size: 38px;
}

.ticket-header h1 {
    font-family: 'Playfair Display', serif;
    font-size: 34px;
    margin: 0 0 10px;
}

.ticket-header p {
    color: #e0cbd0;
    margin: 0;
}

.ticket-body {
    padding: 30px;
}

.ticket-brand {
    color: #ed334c;
    font-weight: 700;
    letter-spacing: 3px;
    text-align: center;
    margin-bottom: 25px;
}

.ticket-line {
    border-top: 1px dashed #514044;
    margin: 25px 0;
}

.ticket-message {
    text-align: center;
    color: #aaa;
    line-height: 1.7;
}

.ticket-actions {
    display: flex;
    gap: 12px;
    margin-top: 28px;
}

.ticket-btn {
    flex: 1;
    padding: 14px 10px;
    text-align: center;
    text-decoration: none;
    border-radius: 9px;
    font-weight: 600;
    font-size: 14px;
}

.primary-btn {
    background: linear-gradient(135deg, #ed334c, #a90d29);
    color: white;
}

.secondary-btn {
    border: 1px solid #514044;
    color: white;
}

.ticket-footer {
    text-align: center;
    color: #777;
    font-size: 11px;
    letter-spacing: 2px;
    padding: 0 20px 25px;
}

@media(max-width: 480px) {
    .ticket-header h1 {
        font-size: 28px;
    }

    .ticket-body {
        padding: 22px;
    }

    .ticket-actions {
        flex-direction: column;
    }
}
</style>
</head>

<body class="success-body">

<div class="ticket">

    <div class="ticket-header">

        <div class="success-icon">✓</div>

        <h1>You're going to the movies!</h1>

        <p>Your booking has been successfully saved.</p>

    </div>

    <div class="ticket-body">

        <div class="ticket-brand">CINEBOOK</div>

        <div class="ticket-line"></div>

        <p class="ticket-message">
            Thank you,
            <strong><%= session.getAttribute("userName") %></strong>!
            <br><br>
            Your next cinematic experience awaits.
            Visit My Bookings to view your booking details.
        </p>

        <div class="ticket-line"></div>

        <div class="ticket-actions">

            <a href="${pageContext.request.contextPath}/my-bookings"
               class="ticket-btn primary-btn">
                View My Bookings
            </a>

            <a href="${pageContext.request.contextPath}/index.jsp"
               class="ticket-btn secondary-btn">
                Back to Home
            </a>

        </div>

    </div>

    <div class="ticket-footer">
        YOUR CINEMA. YOUR MOMENT.
    </div>

</div>

</body>
</html>