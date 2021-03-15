<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 16/02/2021
  Time: 7:39 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Employee</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- jQuery that works -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/8e47f0960d.js" crossorigin="anonymous"></script>

    <!-- style sheets -->
    <link rel="stylesheet" href="styles/random.css" type="text/css"/>

    <!-- toggle the side bar -->
    <script type="text/javascript">
        $(document).ready(function(){

            $("#sidebarToggle").on("click", function(e) {
                e.preventDefault();
                $("body").toggleClass("sb-sidenav-toggled");
            });

        });
    </script>
</head>
<body>

<!-- NAVBAR -->

<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark justify-content-between">
    <div>
        <a class="navbar-brand" href="#"><img src="images/logo-admin.png" alt=""></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
    </div>

    <!-- Dropdown Navbar-->
    <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#"><i class="fas fa-user"></i> ${ADMIN.getFirstName()}</a>
                <a class="dropdown-item" href="#">Activity Log</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="AccountServlet?action=logout">Logout</a>
            </div>
        </li>
    </ul>
</nav>

<!-- PAGE CONTENT -->

<div id="layoutSidenav">

    <!-- Left Panel -->
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading">Core</div>
                    <a class="nav-link" href="adminDashboard.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Dashboard
                    </a>
                    <div class="sb-sidenav-menu-heading">Actions</div>
                    <a class="nav-link" href="adminDashboard.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                        View Employees
                    </a>
                    <a class="nav-link" href="adminDashboard.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-user-plus"></i></div>
                        Add New Employee
                    </a>
                    <div class="sb-sidenav-menu-heading">General</div>
                    <a class="nav-link" href="adminDashboard.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                        Settings
                    </a>
                    <a class="nav-link" href="adminDashboard.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-envelope"></i></div>
                        Messages
                    </a>
                </div>
            </div>
            <div class="sb-sidenav-footer">
                <div class="small">Logged in as:</div>
                ${ADMIN.getFirstName()}
            </div>
        </nav>
    </div>



    <!-- Main Content -->
    <div id="layoutSidenav_content">

        <!-- Main Body -->
        <main>
            <div class="container-fluid">

                <!-- New Employee Tab -->
                <h1 class="mt-4"> ${ORGANISATION.getOrgName()} Dashboard</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item">Dashboard</li>
                    <li class="breadcrumb-item active">Edit Employee Details</li>
                </ol>

                <!-- NEW EMPLOYEE FORM -->
                <h3 class="login-heading mb-4">Edit Employee Details</h3>


                <!-- old template form -->
                <form action="AccountServlet" method="POST">
                    <input type="hidden" name="action" value="editEmployee">

                    <!-- ROW -->
                    <div class="form-row">
                        <!-- First Name -->
                        <div class="form-label-group col-md-6">
                            <input type="text" id="firstname" name="firstname" class="form-control" placeholder="First Name" value="${SINGLEEMPLOYEE.getFirstName()}" required autofocus>
                            <label for="firstname">First Name</label>
                        </div>
                        <!-- Last Name -->
                        <div class="form-label-group col-md-6">
                            <input type="text" id="lastname" name="lastname" class="form-control" placeholder="First Name" value="${SINGLEEMPLOYEE.getLastName()}" required autofocus>
                            <label for="lastname">Last Name</label>
                        </div>
                    </div>


                    <!-- Email -->
                    <div class="form-label-group">
                        <input type="email" id="email" name="email" class="form-control" placeholder="Email" value="${SINGLEEMPLOYEE.getEmail()}" required autofocus>
                        <label for="email">Email</label>
                    </div>


                    <!-- ROW -->
                    <div class="form-row">
                        <!-- Phone -->
                        <div class="form-label-group col-md-6">
                            <input type="number" id="phonenumber" name="phonenumber" class="form-control" placeholder="Phone" value="${SINGLEEMPLOYEE.getPhone()}" required autofocus>
                            <label for="phonenumber">Phone</label>
                        </div>
                        <!-- Gender -->
                        <div class="form-label-group col-md-6">
                            <select class="form-control" name="gender" id="gender">
                                <option value='male'>Male</option>
                                <option value='female'>Female</option>
                            </select>
                        </div>
                    </div>

                    <!-- ROW -->
                    <div class="form-row">
                        <!-- Date -->
                        <div class="form-label-group col-md-4">
                            <select class="form-control" name="date" id="date">
                                <option value='01'>1</option>
                                <option value='02'>2</option>
                                <option value='03'>3</option>
                                <option value='04'>4</option>
                                <option value='05'>5</option>
                                <option value='06'>6</option>
                                <option value='07'>7</option>
                                <option value='08'>8</option>
                                <option value='09'>9</option>
                                <option value='10'>10</option>
                                <option value='11'>11</option>
                                <option value='12'>12</option>
                                <option value='13'>13</option>
                                <option value='14'>14</option>
                                <option value='15'>15</option>
                                <option value='16'>16</option>
                                <option value='17'>17</option>
                                <option value='18'>18</option>
                                <option value='19'>19</option>
                                <option value='20'>20</option>
                                <option value='21'>21</option>
                                <option value='22'>22</option>
                                <option value='23'>23</option>
                                <option value='24'>24</option>
                                <option value='25'>25</option>
                                <option value='26'>26</option>
                                <option value='27'>27</option>
                                <option value='28'>28</option>
                                <option value='29'>29</option>
                                <option value='30'>30</option>
                                <option value='31'>31</option>
                            </select>
                        </div>
                        <!-- Month -->
                        <div class="form-label-group col-md-4">
                            <select class="form-control" name="month" id="month">
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
                        <!-- Year -->
                        <div class="form-label-group col-md-4">
                            <select class="form-control" name="year" id="year">
                                <option value='2003'>2003</option>
                                <option value='2002'>2002</option>
                                <option value='2001'>2001</option>
                                <option value='2000'>2000</option>
                                <option value='1999'>1999</option>
                                <option value='1998'>1998</option>
                                <option value='1997'>1997</option>
                                <option value='1996'>1996</option>
                                <option value='1995'>1995</option>
                                <option value='1994'>1994</option>
                                <option value='1993'>1993</option>
                                <option value='1992'>1992</option>
                                <option value='1991'>1991</option>
                                <option value='1990'>1990</option>
                                <option value='1989'>1989</option>
                                <option value='1988'>1988</option>
                                <option value='1987'>1987</option>
                                <option value='1986'>1986</option>
                                <option value='1985'>1985</option>
                                <option value='1984'>1984</option>
                                <option value='1983'>1983</option>
                                <option value='1982'>1982</option>
                                <option value='1981'>1981</option>
                                <option value='1980'>1980</option>
                            </select>
                        </div>
                    </div>

                    <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2 col-md-6 mx-auto" type="submit">Confirm Edits <i class="fas fa-long-arrow-alt-right"></i></button>
                </form> <!-- end of edit employee -->


                <!-- NEW EMPLOYEE FORM -->
                <h3 class="login-heading mb-4" style="margin-top: 50px;">Change Employee's Picture Password</h3>

                <form action="ImageServlet" method="POST">
                    <input type="hidden" name="imageaction" value="editpassword">
                    <input type="hidden" name="editpassworduserid" value="editpassword">

                    <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2 col-md-6 mx-auto" type="submit">Change Employee Picture Password <i class="fas fa-long-arrow-alt-right"></i></button>
                </form>

            </div>
        </main>

        <!-- Footer -->
        <footer class="py-4 bg-light mt-auto">
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
    </div>

</div>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>
