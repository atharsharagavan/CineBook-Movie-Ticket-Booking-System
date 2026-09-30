package com.cinebook;

import java.io.IOException;
import java.util.Locale;

import org.bson.Document;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (name == null || email == null ||
            password == null || confirmPassword == null ||
            name.isBlank() || email.isBlank()) {

            request.setAttribute("error", "Please fill in all fields.");
            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must contain at least 8 characters.");
            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
            return;
        }

        try {
            MongoDatabase database = MongoDBConnection.getDatabase();

            MongoCollection<Document> users =
                    database.getCollection("user");

            String normalizedEmail = email.trim().toLowerCase(Locale.ROOT);

            if (users.find(Filters.eq("email", normalizedEmail)).first() != null) {
                request.setAttribute("error", "Email is already registered.");
                request.getRequestDispatcher("/register.jsp")
                       .forward(request, response);
                return;
            }

            String hashedPassword = BCrypt.hashpw(
                    password,
                    BCrypt.gensalt(12)
            );

            Document user = new Document("name", name.trim())
                    .append("email", normalizedEmail)
                    .append("password", hashedPassword);

            users.insertOne(user);

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?registered=success"
            );

        } catch (Exception e) {
            getServletContext().log("Registration failed", e);

            request.setAttribute("error",
                    "Registration could not be completed. Please try again.");

            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
        }
    }
}