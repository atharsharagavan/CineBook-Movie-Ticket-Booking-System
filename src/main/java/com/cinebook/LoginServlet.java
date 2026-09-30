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
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.isBlank() || password.isEmpty()) {

            request.setAttribute("error", "Please enter email and password.");
            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
            return;
        }

        try {
            MongoDatabase database = MongoDBConnection.getDatabase();

            MongoCollection<Document> users =
                    database.getCollection("user");

            String normalizedEmail = email.trim().toLowerCase(Locale.ROOT);

            Document user = users.find(
                    Filters.eq("email", normalizedEmail)
            ).first();

            if (user == null ||
                !BCrypt.checkpw(password, user.getString("password"))) {

                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/login.jsp")
                       .forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);

            session.setAttribute("userId", user.getObjectId("_id").toString());
            session.setAttribute("userName", user.getString("name"));
            session.setAttribute("userEmail", user.getString("email"));

            session.setMaxInactiveInterval(30 * 60);

            response.sendRedirect(
                    request.getContextPath() + "/index.jsp"
            );

        } catch (Exception e) {
            getServletContext().log("Login failed", e);

            request.setAttribute("error",
                    "Login could not be completed. Please try again.");

            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
        }
    }
}