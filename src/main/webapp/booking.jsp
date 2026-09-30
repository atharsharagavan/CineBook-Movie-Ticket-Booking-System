<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Book Tickets | CineBook</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/index.jsp"
           class="logo">CINE<span>BOOK</span></a>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <span>Hi, <%= session.getAttribute("userName") %></span>
            <a href="${pageContext.request.contextPath}/logout"
               class="nav-btn">Logout</a>
        </div>
    </nav>

    <section class="movies-section">

        <span class="tag">YOUR NEXT MOVIE NIGHT</span>

        <h1>Book Your Tickets</h1>

        <form action="${pageContext.request.contextPath}/book"
              method="post">

            <label>Select Movie</label>

            <select name="movieId" id="movieId" required>
                <option value="">Loading movies...</option>
            </select>

            <br><br>

            <label>Select Date</label>
            <input type="date" name="showDate" id="showDate" required>

            <br><br>

            <label>Select Show Time</label>

            <select name="showTime" required>
                <option value="">Choose show time</option>
                <option value="10:00 AM">10:00 AM</option>
                <option value="01:30 PM">01:30 PM</option>
                <option value="04:30 PM">04:30 PM</option>
                <option value="07:30 PM">07:30 PM</option>
            </select>

            <br><br>

            <label>Number of Seats</label>

            <input type="number"
                   name="seats"
                   id="seats"
                   min="1"
                   max="10"
                   value="1"
                   required>

            <br><br>

            <p>Ticket Price: ₹<span id="price">0</span> per seat</p>

            <h3>Total: ₹<span id="total">0</span></h3>

            <button type="submit">Continue to Booking</button>

        </form>

    </section>

    <script>
        const contextPath = "${pageContext.request.contextPath}";

        const movieSelect = document.getElementById("movieId");
        const seatsInput = document.getElementById("seats");
        const priceDisplay = document.getElementById("price");
        const totalDisplay = document.getElementById("total");

        let movies = [];

        fetch(contextPath + "/data/movies.json")
            .then(response => {
                if (!response.ok) {
                    throw new Error("Could not load movies");
                }
                return response.json();
            })
            .then(data => {
                movies = data;

                movieSelect.innerHTML =
                    '<option value="">Choose a movie</option>';

                movies.forEach(movie => {
                    const option = document.createElement("option");

                    option.value = movie.id;
                    option.textContent = movie.title;

                    movieSelect.appendChild(option);
                });

                const selectedMovie =
                    new URLSearchParams(window.location.search)
                    .get("movieId");

                if (selectedMovie) {
                    movieSelect.value = selectedMovie;
                }

                updateTotal();
            })
            .catch(error => {
                console.error(error);
                movieSelect.innerHTML =
                    '<option value="">Unable to load movies</option>';
            });

        function updateTotal() {
            const movie = movies.find(
                item => String(item.id) === movieSelect.value
            );

            const price = movie ? Number(movie.price) : 0;
            const seats = Number(seatsInput.value) || 0;

            priceDisplay.textContent = price;
            totalDisplay.textContent = price * seats;
        }

        movieSelect.addEventListener("change", updateTotal);
        seatsInput.addEventListener("input", updateTotal);

        const today = new Date();
        const localDate = new Date(
            today.getTime() - today.getTimezoneOffset() * 60000
        ).toISOString().split("T")[0];

        document.getElementById("showDate").min = localDate;
    </script>

</body>
</html>