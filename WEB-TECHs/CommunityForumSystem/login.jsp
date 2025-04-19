<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Community Forum</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Arial', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
            opacity: 0;
            transform: translateY(-50px);
            transition: all 0.6s ease-in-out;
        }
        .login-container.animate {
            opacity: 1;
            transform: translateY(0);
        }
        h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }
        input:focus {
            border-color: #007bff;
            outline: none;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .btn:hover {
            transform: scale(1.05);
        }
        .message {
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
        .message.error { color: red; }
        .message.success { color: green; }
        .register-link {
            margin-top: 15px;
            font-size: 0.9rem;
        }
        .register-link a {
            color: #007bff;
            text-decoration: none;
        }
        .register-link a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="login-container" id="loginContainer">
        <h2>Login to Community Forum</h2>

        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            if (error != null) {
        %>
            <div class="message error"><%= error %></div>
        <% } else if (success != null) { %>
            <div class="message success"><%= success %></div>
        <% } %>

        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required />
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required />
            </div>
            <div class="form-group">
                <button type="submit" class="btn">Login</button>
            </div>
        </form>

        <div class="register-link">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>

    <script>
        setTimeout(function() {
            document.getElementById('loginContainer').classList.add('animate');
        }, 500);
    </script>
</body>
</html>
