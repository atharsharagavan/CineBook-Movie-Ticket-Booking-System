 CineBook — Movie Ticket Booking System

A web-based movie ticket booking application developed using Java, JSP, Jakarta Servlets, HTML, CSS, JavaScript, and MongoDB.

CineBook allows users to explore movies, create an account, log in, book movie tickets, and view their booking history through a simple and user-friendly interface.

 Features

- User Registration — Create a new account securely.
- User Authentication — Login and logout functionality.
- Movie Listings — Browse available movies dynamically.
- Movie Booking — Select a movie, show date, show time, and number of seats.
- Booking Confirmation — View booking confirmation after submitting a booking.
- My Bookings — Access previously recorded bookings.
- Password Hashing — BCrypt-based password hashing.
- Database Integration — Store user and booking information using MongoDB.
- Responsive UI — Styled pages for a better user experience.

 Tech Stack

Component| Technology
Frontend| HTML, CSS, JavaScript
Backend| Java
Web Technology| JSP, Jakarta Servlets
Database| MongoDB
Server| Apache Tomcat 11
IDE| Eclipse IDE
Authentication| BCrypt

 Project Structure

CineBook/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/cinebook/
│       │       ├── AuthFilter.java
│       │       ├── BookingServlet.java
│       │       ├── LoginServlet.java
│       │       ├── LogoutServlet.java
│       │       ├── MongoDBConnection.java
│       │       ├── MongoDBTest.java
│       │       ├── MyBookingsServlet.java
│       │       └── RegisterServlet.java
│       │
│       └── webapp/
│           ├── css/
│           ├── js/
│           ├── images/
│           ├── data/
│           │   └── movies.json
│           ├── WEB-INF/
│           ├── index.jsp
│           ├── login.jsp
│           ├── register.jsp
│           ├── booking.jsp
│           ├── booking-success.jsp
│           └── my-bookings.jsp
│
└── README.md

 Prerequisites

Before running the project, install:

- Java JDK
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 11
- MongoDB Community Server or MongoDB Atlas
- MongoDB Java Driver dependencies

 Getting Started

1. Clone the repository

git clone https://github.com/atharsharagan/CineBook-Movie-Ticket-Booking-System.git

2. Import into Eclipse

1. Open Eclipse IDE.
2. Select File → Import.
3. Choose General → Existing Projects into Workspace.
4. Select the cloned CineBook folder.
5. Click Finish.

3. Configure MongoDB

Make sure MongoDB is running and configure the connection in "MongoDBConnection.java".

Example local connection:

mongodb://localhost:27017

Database name:

cinebook

Ensure the required MongoDB Java driver dependencies are available in the project.

For MongoDB Atlas, use your own connection URI and keep credentials out of the source code.

4. Run the application

1. Configure Apache Tomcat 11 in Eclipse.
2. Add the CineBook project to the server.
3. Start the server.
4. Open your browser and visit:

http://localhost:8080/CineBook/

 Security

- Passwords are hashed using BCrypt.
- Authentication is managed using Java sessions.
- Protected pages use an authentication filter.
- Database credentials should be stored securely and never committed to a public repository.

Application Modules

Module| Description
Home| Browse available movies
Register| Create a user account
Login| Authenticate users
Booking| Select movie and show details
Booking Confirmation| Display submitted booking details
My Bookings| View booking history

Future Enhancements

- Real-time seat availability
- Online payment gateway integration
- Movie search and filtering
- Admin dashboard for movie management
- Email booking confirmation
- Deployment with a cloud-hosted database

 Developer

Atharsha Ragan

GitHub: "@atharsharagan" (https://github.com/atharsharagan)

 License

This project was developed for academic and educational purposes.