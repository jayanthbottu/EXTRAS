<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="forumApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community Forum | Engage & Learn</title>
    
    <!-- Core CSS & Scripts -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>

    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --text-dark: #2c3e50;
            --text-light: #ecf0f1;
            --gradient-start: #8e9eab;
            --gradient-end: #eef2f3;
        }

        body {
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            position: relative;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            padding: 0.8rem 1rem;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
            font-size: 1.5rem;
            letter-spacing: -0.5px;
        }

        .hero-section {
            padding: 6rem 0 4rem;
            text-align: center;
        }

        .main-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            padding: 3rem;
            margin: 2rem auto;
            transform: translateY(20px);
            opacity: 0;
            transition: all 0.6s cubic-bezier(0.23, 1, 0.32, 1);
        }

        .main-card.animate {
            opacity: 1;
            transform: translateY(0);
        }

        .header-text {
            font-size: 2.75rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            letter-spacing: -0.5px;
            background: linear-gradient(45deg, var(--secondary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .btn-custom {
            padding: 0.8rem 2rem;
            border-radius: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: none;
            margin: 0.5rem;
            min-width: 180px;
        }

        .btn-custom::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(120deg, 
                transparent, 
                rgba(255, 255, 255, 0.3), 
                transparent);
            transition: 0.6s;
        }

        .btn-custom:hover::after {
            left: 100%;
        }

        .btn-primary-custom {
            background: var(--secondary-color);
            color: var(--text-light);
        }

        .btn-success-custom {
            background: var(--accent-color);
            color: var(--text-light);
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 1rem;
            padding: 2rem;
            margin: 1.5rem 0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .footer {
            background: rgba(255, 255, 255, 0.95);
            padding: 1.5rem;
            margin-top: 4rem;
            box-shadow: 0 -2px 15px rgba(0, 0, 0, 0.05);
        }

        @media (max-width: 768px) {
            .header-text {
                font-size: 2rem;
            }
            
            .main-card {
                padding: 2rem;
                margin: 1rem;
            }
            
            .btn-custom {
                width: 100%;
                margin: 0.5rem 0;
            }
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin-bottom: 1rem;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--secondary-color);
        }

        .stat-label {
            color: var(--primary-color);
            opacity: 0.8;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
    </style>
</head>
<body ng-controller="MainController">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-comments me-2"></i>ForumHub
            </a>
            <div class="ml-auto">
                <a href="login.jsp" class="btn btn-sm btn-outline-primary mr-2">Login</a>
                <a href="register.jsp" class="btn btn-sm btn-success">Register</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="main-card animate__animated animate__fadeInUp" id="mainCard">
                <h1 class="header-text mb-4">Welcome to ForumHub</h1>
                <p class="lead text-muted mb-4">
                    Join our vibrant community of thinkers, learners, and experts. 
                    Share knowledge, ask questions, and grow together.
                </p>
                
                <div class="mb-5">
                    <a href="forum.jsp" class="btn btn-primary-custom btn-custom">
                        <i class="fas fa-door-open me-2"></i>Enter Forum
                    </a>
                    <a href="register.jsp" class="btn btn-success-custom btn-custom">
                        <i class="fas fa-user-plus me-2"></i>Join Community
                    </a>
                </div>

                <!-- Stats Row -->
                <div class="row text-center mt-5">
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="stat-number">100+</div>
                            <div class="stat-label">Active Members</div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="stat-number">580+</div>
                            <div class="stat-label">Discussions</div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="stat-number">95%</div>
                            <div class="stat-label">Solved Issues</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container text-center">
            <div class="mb-2">
                <a href="#" class="text-muted mx-3">About Us</a>
                <a href="#" class="text-muted mx-3">Privacy Policy</a>
                <a href="#" class="text-muted mx-3">Terms of Service</a>
            </div>
            <div class="text-muted">
                &copy; {{currentYear}} ForumHub. All rights reserved.
                <div class="mt-1">
                    <i class="fab fa-twitter mx-2"></i>
                    <i class="fab fa-facebook mx-2"></i>
                    <i class="fab fa-linkedin mx-2"></i>
                </div>
            </div>
        </div>
    </footer>

    <script>
        var app = angular.module('forumApp', []);
        app.controller('MainController', function($scope) {
            $scope.currentYear = new Date().getFullYear();

            // Animation trigger
            setTimeout(() => {
                document.getElementById('mainCard').classList.add('animate');
            }, 300);

            // Interactive features
            $scope.features = [
                { 
                    title: "Real-time Discussions",
                    icon: "fa-comments",
                    desc: "Engage in live conversations with community members"
                },
                {
                    title: "Expert Support",
                    icon: "fa-headset",
                    desc: "Get help from certified professionals and industry experts"
                },
                {
                    title: "Knowledge Base",
                    icon: "fa-book-open",
                    desc: "Access our growing library of tutorials and resources"
                }
            ];
        });
    </script>

</body>
</html>