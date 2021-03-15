<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 01/02/2021
  Time: 6:05 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Organisation</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/8e47f0960d.js" crossorigin="anonymous"></script>

    <!-- style sheets -->
    <link rel="stylesheet" href="styles/home.css" type="text/css"/>

</head>
<body>

<!-- Links:
    StartBootstrap Login Template: https://startbootstrap.com/snippets/sign-in-split
    Photo by Photoholgic on Unsplash: https://unsplash.com/photos/AN5G45qartA
-->

<div class="container-fluid">
    <div class="row no-gutter">
        <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image-2"></div>
        <div class="col-md-8 col-lg-6">
            <div class="login d-flex align-items-center py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-9 col-lg-8 mx-auto">
                            <h3 class="login-heading mb-4">Register your organisation!</h3>

                            <form action="OrganisationServlet" method="POST">
                                <input type="hidden" name="action" value="addOrg">

                                <!-- Name -->
                                <div class="form-label-group">
                                    <input type="text" id="orgname" name="orgname" class="form-control" placeholder="Organisation Name" required autofocus>
                                    <label for="orgname">Organisation Name</label>
                                </div>

                                <!-- Email -->
                                <div class="form-label-group">
                                    <input type="email" id="orgemail" name="orgemail" class="form-control" placeholder="Email Address" required autofocus>
                                    <label for="orgemail">Email address</label>
                                </div>

                                <!-- Type -->
                                <div class="form-label-group">
                                    <select class="form-control" name="orgcategory" id="orgcategory">
                                        <option value="education">Education</option>
                                        <option value="technology">Information Technology</option>
                                        <option value="manufacturing">Manufacturing</option>
                                        <option value="agriculture">Agriculture</option>
                                        <option value="finance">Financial Services</option>
                                        <option value="realestate">Real Estate</option>
                                        <option value="healthcare">Healthcare</option>
                                        <option value="energy">Energy</option>
                                        <option value="retail">Retail</option>
                                        <option value="communications">Communications</option>
                                        <option value="entertainment">Entertainment</option>
                                    </select>
                                </div>

                                <!-- Domain -->
                                <div class="form-label-group">
                                    <input type="text" id="orgdomain" name="orgdomain" class="form-control" placeholder="Organisation Domain" required autofocus>
                                    <label for="orgdomain">Organisation Domain</label>
                                </div>

                                <!-- Plan -->
                                <div class="form-label-group">
                                    <select class="form-control" name="orgplan" id="orgplan">
                                        <option value="1">Premium</option>
                                        <option value="2">Enterprise</option>
                                    </select>
                                </div>

                                <!-- Card Number -->
                                <div class="form-label-group">
                                    <input type="number" id="orgcardnum" name="orgcardnum" class="form-control" placeholder="Card Number" required autofocus>
                                    <label for="orgcardnum">Card Number</label>
                                </div>


                                <!-- ROW -->
                                <div class="form-row">

                                    <!-- Card Expiry Month -->
                                    <div class="form-label-group col-md-6">
                                        <select class="form-control" name="orgexpirymm" id="orgexpirymm">
                                            <option value='01'>January</option>
                                            <option value='02'>February</option>
                                            <option value='03'>March</option>
                                            <option value='04'>April</option>
                                            <option value='05'>May</option>
                                            <option value='06'>June</option>
                                            <option value='07'>July</option>
                                            <option value='08'>August</option>
                                            <option value='09'>September</option>
                                            <option value='10'>October</option>
                                            <option value='11'>November</option>
                                            <option value='12'>December</option>
                                        </select>
                                    </div>


                                    <!-- Card Expiry Year -->
                                    <div class="form-label-group col-md-6">
                                        <select class="form-control" name="orgexpiryyy" id="orgexpiryyy">
                                            <option value='2021'>2021</option>
                                            <option value='2022'>2022</option>
                                            <option value='2023'>2023</option>
                                            <option value='2024'>2024</option>
                                            <option value='2025'>2025</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- CVV -->
                                <div class="form-label-group">
                                    <input type="number" id="orgcvv" name="orgcvv" class="form-control" placeholder="Card CVV" required autofocus>
                                    <label for="orgcvv">CVV Number</label>
                                </div>

                                <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2" type="submit">Continue <i class="fas fa-long-arrow-alt-right"></i></button>
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
