<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 18/11/2020
  Time: 9:30 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- jQuery that works -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- style sheets -->
    <link rel="stylesheet" href="styles/home.css" type="text/css"/>

    <script type="text/javascript">
        $(document).ready(function(){
            var scroll_pos = 0;
            $(document).scroll(function() {
                scroll_pos = $(this).scrollTop();
                if(scroll_pos > 100) {
                    $("nav").css('background-color', '#ffffff');
                    $("nav").css('border-bottom', '1px solid black');
                } else {
                    $("nav").css('background-color', 'transparent');
                    $("nav").css('border-bottom', 'none');
                }
            });
        });

    </script>

</head>
<body>

<!-- Links:
    StartBootstrap Video Header Template: https://startbootstrap.com/snippets/video-header
    Video by fauxels on Pexels: https://www.pexels.com/video/person-looking-at-pictures-in-his-phone-while-making-notes-3251809/
    Gifs made with: https://cloudconvert.com/mov-to-gif
    Change navbar color on scroll: https://stackoverflow.com/questions/52637835/dynamically-change-background-color-on-scroll
-->

<header>
    <div class="overlay">
        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <img src="images/logo4.png" alt="">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="index.jsp">Home
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="pricing.jsp">Pricing</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="account.jsp">Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    <video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
        <source src="videos/phone.mp4" type="video/mp4">
    </video>

    <div class="container h-50">
        <div class="d-flex h-100 text-center align-items-center">
            <div class="w-100">
                <h1 class="display-3">Picturesque. Secure.</h1>
                <p class="lead mb-0">A new type of authentication.</p>
            </div>
        </div>
    </div>
</header>

<!-- INFO SECTION -->
<section style="margin-top: 50px;">
    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto">

                <h1 class="display-4 text-center">What is PassPic?</h1>

                <p class="lead mb-0">PassPic aims to change the way people interact with system authentication.</p>

                <p class="lead mb-0">PassPic removes traditional passwords and replaces them with your own photos.</p>

                <p class="lead mb-0">Users of the app click parts of the photo sequentially in order to log in.</p>

                <p class="lead mb-0">This is your Password Picture (PassPic).</p>

                <hr class="my-4 mt-5">

                <h1 class="display-4 text-center">Value Proposition</h1>

                <p class="lead mb-0">By removing traditional passwords, the security of a system has the potential to dramatically increase.</p>

                <p class="lead mb-0">This is because people tend to re-use passwords quite frequently to access all their online accounts.</p>

                <p class="lead mb-0">As such, an account or indeed an entire organization, could be at risk, if someone's re-used password is exposed on another system.</p>

                <p class="lead mb-0">This is the issue PassPic aims to solve.</p>

            </div>
        </div>
    </div>
</section>

<!-- GIF SECTION -->
<section id="gif-section" style="margin-top: 100px; background-color: lightblue">

    <div class="container-fluid" style="margin-top: 50px;">
        <div class="row">
            <div class="col-md-4 col-lg-6">
                <h1 class="display-4 text-center">First you create an account!</h1>
                <p class="lead mb-0">Enter your login details.</p>
            </div>
            <div class="col-md-8 col-lg-6 bg-gif-1"></div>
        </div>
    </div>

    <div class="container-fluid" style="margin-top: 50px;">
        <div class="row">
            <div class="col-md-4 col-lg-6">
                <h1 class="display-4 text-center">Next, choose your image!</h1>
                <p class="lead mb-0">Either upload your own image or choose from millions of free images online.</p>
            </div>
            <div class="col-md-8 col-lg-6 bg-gif-3"></div>
        </div>
    </div>

    <div class="container-fluid" style="margin-top: 50px;">
        <div class="row">
            <div class="col-md-4 col-lg-6">
                <h1 class="display-4 text-center">Finally, create a password!</h1>
                <p class="lead mb-0">Click on any combinations of tiles you desire.</p>
            </div>
            <div class="col-md-8 col-lg-6 bg-gif-2"></div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="py-4 bg-light">
    <div class="container-fluid">
        <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">Copyright &copy; PassPic 2021</div>
            <div>
                <a href="#">Privacy Policy</a>
                &middot;
                <a href="#">Terms &amp; Conditions</a>
            </div>
        </div>
    </div>
</footer>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>