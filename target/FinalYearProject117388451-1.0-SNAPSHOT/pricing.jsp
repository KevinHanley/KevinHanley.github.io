<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 01/02/2021
  Time: 6:44 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pricing</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/8e47f0960d.js" crossorigin="anonymous"></script>

    <!-- style sheets -->
    <link rel="stylesheet" href="styles/pricing.css" type="text/css"/>

</head>
<body>

<!-- Links:
    StartBootstrap Pricing Template: https://startbootstrap.com/snippets/pricing-table
-->

<header>
    <div class="overlay">
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: transparent;">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <img src="images/logo-admin.png" alt="">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="pricing.jsp">Pricing
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="account.jsp">Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

    <section class="pricing py-5">
        <div class="container">
            <div class="row">
                <!-- Free Tier -->
                <div class="col-lg-4">
                    <div class="card mb-5 mb-lg-0">
                        <div class="card-body">
                            <h5 class="card-title text-muted text-uppercase text-center">Free</h5>
                            <h6 class="card-price text-center">€0<span class="period">/month</span></h6>
                            <hr>
                            <ul class="fa-ul">
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Single User</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>1GB Storage</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Unlimited Public Images</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Email Support</li>
                                <li class="text-muted"><span class="fa-li"><i class="fas fa-times"></i></span>Administrator Control</li>
                                <li class="text-muted"><span class="fa-li"><i class="fas fa-times"></i></span>Dedicated Phone Support</li>
                                <li class="text-muted"><span class="fa-li"><i class="fas fa-times"></i></span>Employee Access</li>
                                <li class="text-muted"><span class="fa-li"><i class="fas fa-times"></i></span>24/7 Rapid Support</li>
                            </ul>
                            <a href="account.jsp" class="btn btn-block btn-primary text-uppercase">Sign Up</a>
                        </div>
                    </div>
                </div>
                <!-- Plus Tier -->
                <div class="col-lg-4">
                    <div class="card mb-5 mb-lg-0">
                        <div class="card-body">
                            <h5 class="card-title text-muted text-uppercase text-center">Premium</h5>
                            <h6 class="card-price text-center">€19<span class="period">/month</span></h6>
                            <hr>
                            <ul class="fa-ul">
                                <li><span class="fa-li"><i class="fas fa-check"></i></span><strong>10 Users</strong></li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>15GB Storage</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Unlimited Public Images</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Email Support</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Administrator Control</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Dedicated Phone Support</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Employee Access</li>
                                <li class="text-muted"><span class="fa-li"><i class="fas fa-times"></i></span>24/7 Rapid Support</li>
                            </ul>
                            <a href="companyAccount.jsp" class="btn btn-block btn-primary text-uppercase">Sign Up</a>
                        </div>
                    </div>
                </div>
                <!-- Pro Tier -->
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title text-muted text-uppercase text-center">Enterprise</h5>
                            <h6 class="card-price text-center">€49<span class="period">/month</span></h6>
                            <hr>
                            <ul class="fa-ul">
                                <li><span class="fa-li"><i class="fas fa-check"></i></span><strong>Unlimited Users</strong></li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Unlimited Storage</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Unlimited Public Images</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Email Support</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Administrator Control</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Dedicated Phone Support</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>Employee Access</li>
                                <li><span class="fa-li"><i class="fas fa-check"></i></span>24/7 Rapid Support</li>
                            </ul>
                            <a href="companyAccount.jsp" class="btn btn-block btn-primary text-uppercase">Sign Up</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</header>





<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>

