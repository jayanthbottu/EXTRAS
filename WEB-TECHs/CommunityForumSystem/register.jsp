<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="registerApp">
<head>
    <meta charset="UTF-8">
    <title>Register | Community Forum</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0c1d9f, #2d5c6a);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .register-box {
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 500px;
            backdrop-filter: blur(10px);
        }

        .register-box h2 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .form-group label {
            color: #e0f7e9;
            font-weight: 500;
        }

        .form-control {
            border-radius: 10px;
            border: none;
            padding: 12px;
            background-color: #fff;
            color: #333;
            font-size: 1rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .form-control:focus {
            box-shadow: 0 0 8px #43d9ad;
            outline: none;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 10px;
            background: linear-gradient(90deg, #00c6ff, #0072ff);
            color: white;
            border: none;
            transition: 0.3s;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            background: linear-gradient(90deg, #0072ff, #00c6ff);
        }

        .bottom-link {
            margin-top: 20px;
            text-align: center;
        }

        .bottom-link a {
            color: #f3f3f3;
            text-decoration: underline;
        }

    </style>
</head>

<body ng-controller="RegisterController">

    <div class="register-box">
        <h2>Create Account</h2>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input required type="text" class="form-control" id="username" name="username" placeholder="Enter your username" />
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input required type="email" class="form-control" id="email" name="email" placeholder="example@email.com" />
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input required type="password" class="form-control" id="password" name="password" placeholder="Create a strong password" />
            </div>

            <div class="form-group">
                <label for="role">Select Role</label>
                <select required class="form-control" id="role" name="role">
                    <option value="member">Member</option>
                    <option value="moderator">Moderator</option>
                </select>
            </div>

            <button type="submit" class="btn btn-register">Register</button>
        </form>

        <div class="bottom-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>

    <script>
        var app = angular.module('registerApp', []);
        app.controller('RegisterController', function ($scope) {
            // Future client-side validations or bindings can go here
        });
    </script>

</body>
</html>
