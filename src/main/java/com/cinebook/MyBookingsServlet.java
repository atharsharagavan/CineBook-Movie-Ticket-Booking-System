package com.cinebook;

import java.io.IOException;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Sorts;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String userId = (String) session.getAttribute("userId");

            MongoDatabase database = MongoDBConnection.getDatabase();

            MongoCollection<Document> bookings =
                    database.getCollection("bookings");

            List<Document> myBookings = new ArrayList<>();

            bookings.find(new Document("userId", userId))
                    .sort(Sorts.descending("createdAt"))
                    .into(myBookings);

            request.setAttribute("myBookings", myBookings);

            request.getRequestDispatcher("/my-bookings.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log("Unable to load bookings", e);
            response.sendError(500, "Unable to load your bookings.");
        }
    }
}