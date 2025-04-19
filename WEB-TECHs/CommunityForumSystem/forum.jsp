<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.util.*, java.time.format.DateTimeFormatter, java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Community discussion forum for sharing ideas and knowledge">
    <title>NexusTalk Community Forum</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <style>
        :root {
            --primary: #3a6ea5;
            --primary-light: #4a7fb5;
            --primary-dark: #2a5e95;
            --secondary: #ff6b6b;
            --text-primary: #333;
            --text-secondary: #666;
            --bg-light: #f8f9fa;
            --bg-white: #ffffff;
            --border-color: #e1e4e8;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
            --radius: 8px;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background-color: #f0f2f5;
            color: var(--text-primary);
            line-height: 1.6;
        }

        .navbar {
            background-color: var(--primary);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .navbar-brand i {
            margin-right: 0.5rem;
        }

        .navbar-menu {
            display: flex;
            align-items: center;
        }

        .navbar-item {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            font-weight: 500;
            transition: var(--transition);
        }

        .navbar-item:hover {
            background-color: var(--primary-light);
        }

        .container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .card {
            background-color: var(--bg-white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary);
        }

        .welcome-section {
            text-align: center;
            padding: 2rem 0;
        }

        .welcome-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .welcome-subtitle {
            color: var(--text-secondary);
            font-weight: 400;
        }

        .alert {
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: rgba(40, 167, 69, 0.1);
            border-left-color: var(--success);
            color: #155724;
        }

        .alert-danger {
            background-color: rgba(220, 53, 69, 0.1);
            border-left-color: var(--danger);
            color: #721c24;
        }

        .alert-warning {
            background-color: rgba(255, 193, 7, 0.1);
            border-left-color: var(--warning);
            color: #856404;
        }

        .alert-info {
            background-color: rgba(23, 162, 184, 0.1);
            border-left-color: var(--info);
            color: #0c5460;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-primary);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(58, 110, 165, 0.2);
        }

        .btn {
            display: inline-block;
            font-weight: 500;
            text-align: center;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: var(--radius);
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .post {
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
            background-color: var(--bg-white);
            transition: var(--transition);
        }

        .post:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }

        .post-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            background-color: var(--bg-light);
        }

        .post-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .post-meta {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .post-author {
            display: flex;
            align-items: center;
        }

        .post-author i {
            margin-right: 0.35rem;
        }

        .post-timestamp {
            display: flex;
            align-items: center;
        }

        .post-timestamp i {
            margin-right: 0.35rem;
        }

        .post-content {
            padding: 1.5rem;
            font-size: 1rem;
            color: var(--text-primary);
            line-height: 1.7;
        }

        .post-actions {
            padding: 0.75rem 1.5rem;
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 1rem;
        }

        .post-action {
            display: flex;
            align-items: center;
            color: var(--text-secondary);
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .post-action:hover {
            color: var(--primary);
        }

        .post-action i {
            margin-right: 0.5rem;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
            gap: 0.5rem;
        }

        .page-item {
            margin: 0 0.25rem;
        }

        .page-link {
            display: block;
            padding: 0.5rem 0.75rem;
            color: var(--primary);
            background-color: var(--bg-white);
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            transition: var(--transition);
        }

        .page-link:hover {
            background-color: var(--bg-light);
        }

        .page-link.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .footer {
            background-color: var(--primary);
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .footer-section {
            flex: 1;
            min-width: 300px;
            margin-bottom: 1.5rem;
        }

        .footer-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .footer-links {
            list-style: none;
        }

        .footer-link {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            margin-bottom: 0.5rem;
            display: block;
            transition: var(--transition);
        }

        .footer-link:hover {
            color: white;
        }

        .footer-social {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.1);
            transition: var(--transition);
        }

        .social-icon:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .copyright {
            text-align: center;
            padding-top: 1.5rem;
            margin-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 0.875rem;
            color: rgba(255, 255, 255, 0.7);
        }

        @media (max-width: 768px) {
            .post-meta {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .navbar-container {
                flex-direction: column;
                gap: 1rem;
            }
            
            .footer-section {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="index.jsp" class="navbar-brand">
                <i class="fas fa-comments"></i> NexusTalk
            </a>
            <div class="navbar-menu">
                <a href="index.jsp" class="navbar-item">
                    <i class="fas fa-home"></i> Home
                </a>
                <%
                    String username = (String) session.getAttribute("username");
                    if (username != null) {
                %>
                    <a href="profile.jsp" class="navbar-item">
                        <i class="fas fa-user"></i> Profile
                    </a>
                    <a href="logout.jsp" class="navbar-item">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                <% } else { %>
                    <a href="login.jsp" class="navbar-item">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                    <a href="register.jsp" class="navbar-item">
                        <i class="fas fa-user-plus"></i> Register
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Welcome Section -->
        <% if (username != null) { %>
            <div class="welcome-section">
                <h2 class="welcome-title">Welcome back, <%= username %>!</h2>
                <p class="welcome-subtitle">Join the conversation and share your thoughts with our community.</p>
            </div>
        <% } else { %>
            <div class="welcome-section">
                <h2 class="welcome-title">Welcome to NexusTalk Community Forum</h2>
                <p class="welcome-subtitle">Please <a href="login.jsp">login</a> or <a href="register.jsp">register</a> to participate in discussions.</p>
            </div>
        <% } %>

        <!-- Post Creation Form -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title"><i class="fas fa-edit"></i> Create New Post</h3>
            </div>
            <div class="card-body">
                <% if (username != null) { %>
                    <form method="post" action="forum.jsp" id="postForm">
                        <div class="form-group">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" id="title" name="title" class="form-control" required 
                                   placeholder="Enter a descriptive title for your post" maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="content" class="form-label">Content</label>
                            <textarea id="content" name="content" rows="5" class="form-control" required
                                      placeholder="Share your thoughts with the community..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Post
                        </button>
                    </form>
                <% } else { %>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i> You need to be logged in to create a new post.
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Display Forum Posts -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title"><i class="fas fa-clipboard-list"></i> Recent Discussions</h3>
            </div>
            <div class="card-body">
                <% 
                    // Process form submission
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        // Retrieve form data
                        String title = request.getParameter("title");
                        String content = request.getParameter("content");
                        
                        if (username == null) {
                %>
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle"></i> You must be logged in to post content.
                            </div>
                <%
                        } else if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                %>
                            <div class="alert alert-warning">
                                <i class="fas fa-exclamation-triangle"></i> Title and content are required.
                            </div>
                <%
                        } else {
                            // Database connection details
                            String DB_URL = "jdbc:mariadb://localhost:3306/forum_db"; 
                            String DB_USER = "root"; 
                            String DB_PASSWORD = "admin"; 
                            
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            
                            try {
                                // Initialize the database connection
                                Class.forName("org.mariadb.jdbc.Driver");
                                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                                
                                // Use parameterized query to prevent SQL injection
                                String sql = "INSERT INTO posts (title, content, username) VALUES (?, ?, ?)";
                                stmt = conn.prepareStatement(sql);
                                stmt.setString(1, title);
                                stmt.setString(2, content);
                                stmt.setString(3, username);
                                
                                // Execute the query
                                int rowsAffected = stmt.executeUpdate();
                                
                                if (rowsAffected > 0) {
                %>
                                    <div class="alert alert-success">
                                        <i class="fas fa-check-circle"></i> Your post has been published successfully!
                                    </div>
                <%
                                } else {
                %>
                                    <div class="alert alert-danger">
                                        <i class="fas fa-times-circle"></i> There was an issue publishing your post. Please try again.
                                    </div>
                <%
                                }
                            } catch (Exception e) {
                %>
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-circle"></i> Error: <%= e.getMessage() %>
                                </div>
                <%
                            } finally {
                                // Close database resources
                                try {
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }

                    // Database connection for retrieving posts
                    String DB_URL = "jdbc:mariadb://localhost:3306/forum_db"; 
                    String DB_USER = "root"; 
                    String DB_PASSWORD = "admin"; 
                    
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    
                    try {
                        // Initialize the database connection
                        Class.forName("org.mariadb.jdbc.Driver");
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                        
                        // Retrieve all forum posts from database (no pagination)
                        String sql = "SELECT * FROM posts ORDER BY created_at DESC";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        
                        // Check if there are any posts
                        boolean hasPosts = false;
                        
                        // Display posts
                        while (rs.next()) {
                            hasPosts = true;
                            String postTitle = rs.getString("title");
                            String postContent = rs.getString("content");
                            String postUsername = rs.getString("username");
                            String createdAt = rs.getString("created_at");
                            
                            // Format the date for better readability
                            String formattedDate = createdAt;
                            try {
                                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MMM d, yyyy 'at' h:mm a");
                                LocalDateTime dateTime = LocalDateTime.parse(createdAt, inputFormatter);
                                formattedDate = dateTime.format(outputFormatter);
                            } catch (Exception e) {
                                // If date parsing fails, use the original format
                            }
                %>
                            <div class="post">
                                <div class="post-header">
                                    <h3 class="post-title"><%= postTitle %></h3>
                                    <div class="post-meta">
                                        <div class="post-author">
                                            <i class="fas fa-user"></i> <%= postUsername %>
                                        </div>
                                        <div class="post-timestamp">
                                            <i class="far fa-clock"></i> <%= formattedDate %>
                                        </div>
                                    </div>
                                </div>
                                <div class="post-content">
                                    <%= postContent %>
                                </div>
                                <div class="post-actions">
                                    <div class="post-action">
                                        <i class="far fa-thumbs-up"></i> Like
                                    </div>
                                    <div class="post-action">
                                        <i class="far fa-comment"></i> Reply
                                    </div>
                                    <div class="post-action">
                                        <i class="far fa-share-square"></i> Share
                                    </div>
                                </div>
                            </div>
                <%
                        }
                        
                        if (!hasPosts) {
                %>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> No posts found. Be the first to start a discussion!
                            </div>
                <%
                        }
                    } catch (Exception e) {
                %>
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> Error loading posts: <%= e.getMessage() %>
                        </div>
                <%
                    } finally {
                        // Close database resources
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3 class="footer-title">About NexusTalk</h3>
                <p>NexusTalk is a community-driven forum dedicated to fostering meaningful conversations and knowledge sharing.</p>
                <div class="footer-social">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            
            <div class="footer-section">
                <h3 class="footer-title">Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="index.jsp" class="footer-link">Home</a></li>
                    <li><a href="forum.jsp" class="footer-link">Forums</a></li>
                    <li><a href="faq.jsp" class="footer-link">FAQ</a></li>
                    <li><a href="contact.jsp" class="footer-link">Contact Us</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h3 class="footer-title">Community</h3>
                <ul class="footer-links">
                    <li><a href="guidelines.jsp" class="footer-link">Community Guidelines</a></li>
                    <li><a href="privacy.jsp" class="footer-link">Privacy Policy</a></li>
                    <li><a href="terms.jsp" class="footer-link">Terms of Service</a></li>
                    <li><a href="report.jsp" class="footer-link">Report an Issue</a></li>
                </ul>
            </div>
        </div>
        
        <div class="copyright">
            <p>&copy; <%= java.time.Year.now() %> NexusTalk. All rights reserved.</p>
        </div>
    </footer>

    <!-- Simple JavaScript for enhancing user experience -->
    <script>
        // Function to show a temporary notification when actions are clicked
        document.addEventListener('DOMContentLoaded', function() {
            const postActions = document.querySelectorAll('.post-action');
            
            postActions.forEach(action => {
                action.addEventListener('click', function() {
                    // Get the text of the action (Like, Reply, Share)
                    const actionText = this.textContent.trim();
                    
                    // Show a simple alert (in a real app, this would be replaced with more sophisticated handling)
                    alert('This ' + actionText + ' feature will be implemented in the future update!');
                });
            });
            
            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    setTimeout(() => {
                        alert.style.display = 'none';
                    }, 500);
                }, 5000);
            });
        });
    </script>
</body>
</html>