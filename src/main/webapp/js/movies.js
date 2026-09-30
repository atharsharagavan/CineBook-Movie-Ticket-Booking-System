const movieContainer = document.getElementById("movie-container");

const contextPath = window.location.pathname
    .split("/")
    .slice(0, 2)
    .join("/");

fetch(`${contextPath}/data/movies.json`)
    .then(response => {
        if (!response.ok) {
            throw new Error("Could not load movies");
        }
        return response.json();
    })
    .then(movies => {
        movieContainer.innerHTML = "";

        movies.forEach(movie => {
            const card = document.createElement("div");
            card.className = "movie-card";

            const bookingUrl =
                `${contextPath}/booking.jsp?movieId=${encodeURIComponent(movie.id)}`;

            card.innerHTML = `
                <div class="movie-poster">
                    <img
                        src="${contextPath}/images/${movie.poster}"
                        alt="${movie.title} poster"
                        class="poster-image">
                </div>

                <div class="movie-info">
                    <h3>${movie.title}</h3>
                    <p>${movie.genre} • ${movie.language}</p>
                    <p>⭐ ${movie.rating} | ${movie.duration}</p>

                    <div class="movie-bottom">
                        <strong>₹${movie.price}</strong>
                        <a href="${bookingUrl}" class="book-btn">
                            Book Now
                        </a>
                    </div>
                </div>
            `;

            movieContainer.appendChild(card);
        });
    })
    .catch(error => {
        console.error(error);
        movieContainer.innerHTML =
            "<p>Unable to load movies. Please try again.</p>";
    });