import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/forum_db"; 
    private static final String DB_USER = "root"; // Replace with your MySQL username
    private static final String DB_PASSWORD = "admin"; // Replace with your MySQL password

    // Method to handle POST requests (registration)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data from the request
        try {
            Class.forName("org.mariadb.jdbc.Driver"); // This manually loads the MariaDB driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=JDBC Driver not found.");
            return;
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation
        if (username == null || username.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=Please fill all fields");
            return;
        }

        // Insert the user into the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int rowsAffected = stmt.executeUpdate();

            // If registration is successful, redirect to login
            if (rowsAffected > 0) {
                response.sendRedirect("login.jsp?success=Registration successful! Please login.");
            } else {
                // If something went wrong, show error message
                response.sendRedirect("register.jsp?error=Registration failed. Please try again.");
            }
        } catch (SQLException e) {
            // Log and show database error
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error: " + e.getMessage());
        }
    }
}
