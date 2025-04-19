<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.time.format.DateTimeFormatter, java.time.LocalDateTime, java.util.ArrayList" %>
<%
    // Authentication check
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    String created_at = "";

    ArrayList<String> posts = new ArrayList<>();
    ArrayList<String> postTitles = new ArrayList<>();
    ArrayList<String> postContents = new ArrayList<>();
    ArrayList<String> postDates = new ArrayList<>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        String URL = "jdbc:mariadb://localhost:3306/forum_db"; 
        String dbUser = "root";
        String dbPassword = "admin";

        conn = DriverManager.getConnection(URL, dbUser, dbPassword);

        // Get user creation date
        String sql = "SELECT created_at FROM users WHERE username = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
            created_at = rs.getString("created_at");
        }

        // Get user posts
        String postSql = "SELECT id, title, content, created_at FROM posts WHERE username = ? ORDER BY created_at DESC";
        ps = conn.prepareStatement(postSql);
        ps.setString(1, username);
        rs = ps.executeQuery();

        while (rs.next()) {
            postTitles.add(rs.getString("title"));
            postContents.add(rs.getString("content"));
            String postDate = rs.getString("created_at");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime postDateTime = LocalDateTime.parse(postDate, formatter);
            postDates.add(postDateTime.format(DateTimeFormatter.ofPattern("MMMM dd, yyyy")));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    if (created_at == null || created_at.isEmpty()) {
        created_at = "Account creation date not available.";
    } else {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(created_at, formatter);
        created_at = dateTime.format(DateTimeFormatter.ofPattern("MMMM dd, yyyy"));
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= username %>'s Profile | ForumHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --success: #4cc9f0;
            --card-shadow: 0 10px 30px -15px rgba(0, 0, 0, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            color: var(--dark);
            min-height: 100vh;
            padding-bottom: 50px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header Styles */
        .profile-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin: 20px 0;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            z-index: -1;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            color: var(--primary);
            font-size: 40px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .profile-username {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .profile-role {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .profile-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .meta-icon {
            font-size: 18px;
        }

        /* Posts Section */
        .posts-section {
            margin-top: 40px;
        }

        .section-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 25px;
            color: var(--dark);
            position: relative;
            padding-bottom: 10px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: var(--accent);
            border-radius: 3px;
        }

        .posts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        .post-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px -10px rgba(0, 0, 0, 0.2);
        }

        .post-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: var(--accent);
        }

        .post-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--primary);
        }

        .post-content {
            color: var(--gray);
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .post-date {
            font-size: 13px;
            color: var(--gray);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .no-posts {
            background: white;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            box-shadow: var(--card-shadow);
        }

        .no-posts-icon {
            font-size: 50px;
            color: var(--gray);
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .no-posts-text {
            color: var(--gray);
            font-size: 16px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .posts-grid {
                grid-template-columns: 1fr;
            }
            
            .profile-header {
                padding: 20px;
            }
            
            .profile-username {
                font-size: 24px;
            }
        }

        /* Floating Action Button */
        .fab {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: var(--accent);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: 0 5px 20px rgba(247, 37, 133, 0.4);
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 100;
        }

        .fab:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 25px rgba(247, 37, 133, 0.5);
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-avatar">
                <%= username.substring(0, 1).toUpperCase() %>
            </div>
            <h1 class="profile-username"><%= username %></h1>
            <span class="profile-role"><%= email %></span>
            
            <div class="profile-meta">

                <div class="meta-item">
                    <i class="fas fa-calendar-alt meta-icon"></i>
                    <span>Joined <%= created_at %></span>
                </div>
            </div>
        </div>

        <!-- Posts Section -->
        <div class="posts-section">
            <h2 class="section-title">Your Posts</h2>
            
            <% if (postTitles.isEmpty()) { %>
                <div class="no-posts">
                    <div class="no-posts-icon">
                        <i class="far fa-comment-dots"></i>
                    </div>
                    <p class="no-posts-text">You haven't created any posts yet.</p>
                </div>
            <% } else { %>
                <div class="posts-grid">
                    <% for (int i = 0; i < postTitles.size(); i++) { %>
                        <div class="post-card">
                            <h3 class="post-title"><%= postTitles.get(i) %></h3>
                            <p class="post-content"><%= postContents.get(i) %></p>
                            <p class="post-date">
                                <i class="far fa-clock"></i>
                                <%= postDates.get(i) %>
                            </p>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Floating Action Button -->
    <a href="forum.jsp" class="fab">
        <i class="fas fa-plus"></i>
    </a>
</body>
</html>