<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 11/12/2020
  Time: 1:20 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign In</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- style sheets -->
    <link rel="stylesheet" href="styles/home.css" type="text/css"/>

</head>
<body>

<!-- Links:
    StartBootstrap Login Template: https://startbootstrap.com/snippets/sign-in-split
    Image by Tyler Nix on Unsplash: https://unsplash.com/photos/6mze64HRU2Q
-->


<div class="container-fluid">
    <div class="row no-gutter">
        <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
        <div class="col-md-8 col-lg-6">
            <div class="login d-flex align-items-center py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-9 col-lg-8 mx-auto">
                            ${EMAILERROR}
                            <h3 class="login-heading mb-4">Welcome back!</h3>
                            <form action="AccountServlet" method="POST">
                                <input type="hidden" name="action" value="login">

                                <div class="form-label-group">
                                    <input type="email" id="loginEmailAddress" name="loginEmailAddress" class="form-control" placeholder="Email address" required autofocus>
                                    <label for="loginEmailAddress">Email address</label>
                                </div>

                                <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" type="submit">Sign in  <i class="fas fa-long-arrow-alt-right"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>
