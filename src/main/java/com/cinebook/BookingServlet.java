package com.cinebook;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.bson.Document;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String movieId = request.getParameter("movieId");
        String showDate = request.getParameter("showDate");
        String showTime = request.getParameter("showTime");
        String seatsText = request.getParameter("seats");

        List<String> validMovies = Arrays.asList(
                "1", "2", "3", "4"
        );
        

        List<String> validTimes = Arrays.asList(
                "10:00 AM", "01:30 PM", "04:30 PM", "07:30 PM"
        );

        try {
            if (movieId == null || !validMovies.contains(movieId)
                    || showDate == null || showTime == null
                    || !validTimes.contains(showTime)
                    || seatsText == null) {
                response.sendError(400, "Invalid booking details.");
                return;
            }

            LocalDate date = LocalDate.parse(showDate);

            if (date.isBefore(LocalDate.now())) {
                response.sendError(400, "Please select a future date.");
                return;
            }

            int seats = Integer.parseInt(seatsText);

            if (seats < 1 || seats > 10) {
                response.sendError(400, "Seat count must be between 1 and 10.");
                return;
            }

            MongoDatabase database = MongoDBConnection.getDatabase();

            MongoCollection<Document> bookings =
                    database.getCollection("bookings");

            int ticketPrice = 150;
            int totalPrice = ticketPrice * seats;

            Document booking = new Document()
                    .append("userId", session.getAttribute("userId"))
                    .append("userName", session.getAttribute("userName"))
                    .append("movieId", movieId)
                    .append("showDate", showDate)
                    .append("showTime", showTime)
                    .append("seats", seats)
                    .append("ticketPrice", ticketPrice)
                    .append("totalPrice", totalPrice)
                    .append("status", "CONFIRMED")
                    .append("createdAt", new java.util.Date());

            bookings.insertOne(booking);

            response.sendRedirect(
                    request.getContextPath() + "/booking-success.jsp"
            );

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid seat count.");

        } catch (Exception e) {
            getServletContext().log("Booking failed", e);
            response.sendError(500, "Unable to complete booking.");
        }
    }
}