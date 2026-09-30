
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Book Tickets | CineBook</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/booking.css">
</head>

<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
        CINE<span>BOOK</span>
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/my-bookings.jsp">My Bookings</a>
        <span class="user-greeting">
            Hi, <%= session.getAttribute("userName") %>
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            Logout
        </a>
    </div>
</nav>

<main class="booking-page">

    <div class="page-heading">
        <span class="eyebrow">YOUR NEXT MOVIE NIGHT</span>
        <h1>Make it a <span>movie night.</span></h1>
        <p>Pick your movie, choose your show, and get ready for the big screen.</p>
    </div>

    <div class="booking-layout">

        <section class="booking-card">

            <div class="card-heading">
                <div>
                    <span class="step-label">STEP 01</span>
                    <h2>Your Booking</h2>
                </div>
                <span class="ticket-icon">✦</span>
            </div>

            <form action="${pageContext.request.contextPath}/book"
                  method="post"
                  id="bookingForm">

                <div class="form-group">
                    <label for="movieId">Choose your movie</label>
                    <select name="movieId" id="movieId" required>
                        <option value="">Loading movies...</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="showDate">Select date</label>
                    <input type="date"
                           name="showDate"
                           id="showDate"
                           required>
                </div>

                <div class="form-group">
                    <label for="showTime">Choose showtime</label>

                    <select name="showTime" id="showTime" required>
                        <option value="">Select a showtime</option>
                        <option value="10:00 AM">10:00 AM</option>
                        <option value="01:30 PM">01:30 PM</option>
                        <option value="04:30 PM">04:30 PM</option>
                        <option value="07:30 PM">07:30 PM</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="seats">Number of tickets</label>

                    <div class="seat-control">
                        <button type="button" id="decreaseSeats"
                                class="seat-btn" aria-label="Decrease seats">−</button>

                        <input type="number"
                               name="seats"
                               id="seats"
                               min="1"
                               max="10"
                               value="1"
                               required>

                        <button type="button" id="increaseSeats"
                                class="seat-btn" aria-label="Increase seats">+</button>
                    </div>
                    <small>Choose between 1 and 10 tickets.</small>
                </div>

                <div class="mobile-summary">
                    <span>Total amount</span>
                    <strong>₹<span id="mobileTotal">0</span></strong>
                </div>

                <button type="submit" class="confirm-btn">
                    Confirm Booking <span>→</span>
                </button>

                <p class="secure-note">✦ Your movie night starts here.</p>

            </form>
        </section>

        <aside class="summary-card">

            <div class="summary-top">
                <span class="summary-label">YOUR TICKET SUMMARY</span>
                <div class="cinema-symbol">C</div>
                <h2>CineBook</h2>
                <p>Lights. Camera. Your seat.</p>
            </div>

            <div class="ticket-divider">
                <span></span>
                <span></span>
            </div>

            <div class="summary-details">
                <div class="detail-row">
                    <span>Movie</span>
                    <strong id="summaryMovie">Choose a movie</strong>
                </div>

                <div class="detail-row">
                    <span>Date</span>
                    <strong id="summaryDate">Select date</strong>
                </div>

                <div class="detail-row">
                    <span>Showtime</span>
                    <strong id="summaryTime">Select time</strong>
                </div>

                <div class="detail-row">
                    <span>Tickets</span>
                    <strong><span id="summarySeats">1</span> seat(s)</strong>
                </div>
            </div>

            <div class="price-box">
                <div>
                    <span>Price per ticket</span>
                    <strong>₹<span id="price">0</span></strong>
                </div>

                <div class="total-row">
                    <span>Total Amount</span>
                    <strong>₹<span id="total">0</span></strong>
                </div>
            </div>

            <div class="ticket-footer">
                <span>ENJOY THE SHOW</span>
                <span>✦ ✦ ✦</span>
            </div>

        </aside>

    </div>
</main>

<script>
    const contextPath = "${pageContext.request.contextPath}";

    const movieSelect = document.getElementById("movieId");
    const seatsInput = document.getElementById("seats");
    const dateInput = document.getElementById("showDate");
    const timeSelect = document.getElementById("showTime");

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
                new URLSearchParams(window.location.search).get("movieId");

            if (selectedMovie) {
                movieSelect.value = selectedMovie;
            }

            updateSummary();
        })
        .catch(error => {
            console.error(error);
            movieSelect.innerHTML =
                '<option value="">Unable to load movies</option>';
        });

    function updateSummary() {
        const movie = movies.find(
            item => String(item.id) === movieSelect.value
        );

        const price = movie ? Number(movie.price) : 0;
        const seats = Number(seatsInput.value) || 0;
        const total = price * seats;

        document.getElementById("price").textContent = price;
        document.getElementById("total").textContent = total;
        document.getElementById("mobileTotal").textContent = total;

        document.getElementById("summaryMovie").textContent =
            movie ? movie.title : "Choose a movie";

        document.getElementById("summarySeats").textContent = seats;

        document.getElementById("summaryTime").textContent =
            timeSelect.value || "Select time";

        if (dateInput.value) {
            const [year, month, day] = dateInput.value.split("-");
            document.getElementById("summaryDate").textContent =
                `${day}/${month}/${year}`;
        } else {
            document.getElementById("summaryDate").textContent = "Select date";
        }
    }

    movieSelect.addEventListener("change", updateSummary);
    seatsInput.addEventListener("input", updateSummary);
    dateInput.addEventListener("change", updateSummary);
    timeSelect.addEventListener("change", updateSummary);

    document.getElementById("decreaseSeats").addEventListener("click", () => {
        seatsInput.value = Math.max(1, Number(seatsInput.value) - 1);
        updateSummary();
    });

    document.getElementById("increaseSeats").addEventListener("click", () => {
        seatsInput.value = Math.min(10, Number(seatsInput.value) + 1);
        updateSummary();
    });

    const today = new Date();
    const localDate = new Date(
        today.getTime() - today.getTimezoneOffset() * 60000
    ).toISOString().split("T")[0];

    dateInput.min = localDate;

    updateSummary();
</script>

</body>
</html>
