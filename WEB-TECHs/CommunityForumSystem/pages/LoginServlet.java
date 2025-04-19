import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/forum_db"; 
    private static final String DB_USER = "root"; // Replace with your MySQL username
    private static final String DB_PASSWORD = "admin"; // Replace with your MySQL password

    // Method to handle POST requests (login authentication)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=Please fill all fields");
            return;
        }

        try {
            // Load the MariaDB JDBC driver
            Class.forName("org.mariadb.jdbc.Driver");

            // Establish a database connection
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // If user found, create a session
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("email", rs.getString("email"));  // Storing the user's email in the session
                    response.sendRedirect("forum.jsp");
                } else {
                    // If authentication fails, redirect with error
                    response.sendRedirect("login.jsp?error=Invalid username or password");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database error: " + e.getMessage());
        }
    }
}