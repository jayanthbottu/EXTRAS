<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // Get the current session (implicitly available in JSP)
    
    // If there is an active session, invalidate it
    if (session != null) {
        session.invalidate();  // This will clear all session attributes
    }

    // Wait for 3 seconds before redirecting
    response.setHeader("Refresh", "3; URL=index.jsp");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logging Out</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Container for the content */
        .logout-container {
            background: #fff;
            padding: 20px 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
            max-width: 400px;
            width: 100%;
        }

        .logout-container h2 {
            font-size: 24px;
            color: #2f4f4f;
            margin-bottom: 15px;
        }

        .logout-container p {
            font-size: 16px;
            color: #555;
            margin-bottom: 30px;
        }

        /* Stylish loading dots */
        .dots {
            font-size: 24px;
            color: #2f87f0;
        }

        /* Redirect message style */
        .redirect-msg {
            font-size: 14px;
            color: #888;
        }
    </style>
</head>
<body>

    <div class="logout-container">
        <h2>You have been successfully logged out.</h2>
        <p>You will be redirected to the home page in <span class="dots">...</span></p>
        <p class="redirect-msg">Please wait while we log you out...</p>
    </div>

</body>
</html>
