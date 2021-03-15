<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 04/02/2021
  Time: 4:33 p.m.
  To change this template use File | Settings | File Templates.
--%>

<!-- References -->
<!-- installing jstl library: https://stackoverflow.com/questions/31043869/intellij-and-jsp-jstl-cannot-resolve-taglib-for-jstl-in-tomcat7 -->
<%--jQuery Not Working Resolution: https://stackoverflow.com/questions/19830689/why-is-the-jquery-script-not-working--%>
<%--Bootstrap Modal Not Working: https://stackoverflow.com/questions/28388524/bootstrap-modal-not-popping-up/28388839--%>
<%--Bootstrap show.bs / shown.bs Errors: https://stackoverflow.com/questions/19279629/bootstrap-jquery-show-bs-modal-event-wont-fire--%>
<%--Bootstrap List Group: https://getbootstrap.com/docs/4.6/components/list-group/--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>

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

            //Modal code for deleting a user.
            $('#confirm-delete').on('show.bs.modal', function(e) {

                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));

                var button = $(e.relatedTarget); //button that was clicked
                var username = button.data('whatever');
                var modal = $(this);
                //Put the users name into the modal message
                modal.find('.modal-body .p1').text("Are you sure you want to remove:");
                modal.find('.modal-body h2').text(username);
                modal.find('.modal-body .p2').text("This change cannot be undone?");
            });

            //Modal code for deleting the organisation.
            $('#confirm-org-delete').on('show.bs.modal', function(e) {

                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));

                var button = $(e.relatedTarget); //button that was clicked
                var modal = $(this);
                //Put the users name into the modal message
                modal.find('.modal-body .p1').text("Are you sure you want to delete the account?");
                modal.find('.modal-body .p2').text("This cannot be undone and all data will be lost.");
            });

            //Modal code for deleting a message.
            $('#confirm-message-delete').on('show.bs.modal', function(e) {

                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));

                var button = $(e.relatedTarget); //button that was clicked
                var modal = $(this);
                //Put the users name into the modal message
                modal.find('.modal-body .p1').text("Are you sure you want to remove this message?");
                modal.find('.modal-body .p2').text("This cannot be undone.");
            });
        });
    </script>

</head>
<body>

<!--
    Links:
    CSS Adapted from free template on StartBootstrap: https://startbootstrap.com/template/sb-admin
-->


<!-- modal to appear when pressing delete button on a record -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                Confirm Employee Deletion
            </div>
            <div class="modal-body">
                <p class="p1">message</p>
                <h2>message</h2>
                <p class="p2">message</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger btn-ok">Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- modal to appear when pressing delete button on a record -->
<div class="modal fade" id="confirm-org-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                Confirm Organisation Deletion
            </div>
            <div class="modal-body">
                <p class="p1">message</p>
                <p class="p2">message</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger btn-ok">Delete</a>
            </div>
        </div>
    </div>
</div>


<!-- modal to appear when pressing delete button on a record -->
<div class="modal fade" id="confirm-message-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                Confirm Message Deletion
            </div>
            <div class="modal-body">
                <p class="p1">message</p>
                <p class="p2">message</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger btn-ok">Delete</a>
            </div>
        </div>
    </div>
</div>




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
                    <a class="nav-link" data-toggle="list" href="#list-dashboard" role="tab" aria-controls="dashboard" id="list-dashboard-list">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        Dashboard
                    </a>
                    <div class="sb-sidenav-menu-heading">Actions</div>
                    <a class="nav-link" data-toggle="list" href="#list-employees" role="tab" aria-controls="employees" id="list-employees-list">
                        <div class="sb-nav-link-icon"><i class="fas fa-list"></i></div>
                        View Employees
                    </a>
                    <a class="nav-link" data-toggle="list" href="#list-add" role="tab" aria-controls="add" id="list-add-list">
                        <div class="sb-nav-link-icon"><i class="fas fa-user-plus"></i></div>
                        Add New Employee
                    </a>
                    <div class="sb-sidenav-menu-heading">General</div>
                    <a class="nav-link" data-toggle="list" href="#list-settings" role="tab" aria-controls="settings" id="list-settings-list">
                        <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                        Settings
                    </a>
                    <a class="nav-link" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages" id="list-messages-list">
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

                <div class="tab-content" id="nav-tabContent">

                    <!-- Dashboard Tab -->
                    <div class="tab-pane show active" id="list-dashboard" role="tabpanel" aria-labelledby="list-dashboard-list">

                        <!-- This message is dynamically displayed if an employee is add or deleted -->
                        ${ADMINMESSAGE}

                        <h1 class="mt-4"> ${ORGANISATION.getOrgName()} Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>


                        <!-- INFORMATION TABLE -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                Company Information
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable2" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>Category</th>
                                            <th>Details</th>
                                        </tr>
                                        </thead>
                                        <tfoot>
                                        <tr>
                                            <th>Category</th>
                                            <th>Details</th>
                                        </tr>
                                        </tfoot>
                                        <tbody>
                                        <tr>
                                            <td>Organisation Name</td>
                                            <td>${ORGANISATION.getOrgName()}</td>
                                        </tr>
                                        <tr>
                                            <td> OrganisationID</td>
                                            <td>${ORGANISATION.getOrgID()}</td>
                                        </tr>
                                        <tr>
                                            <td>Contact Email</td>
                                            <td>${ORGANISATION.getOrgEmail()}</td>
                                        </tr>
                                        <tr>
                                            <td>Business Category</td>
                                            <td>${ORGANISATION.getOrgCategory()}</td>
                                        </tr>
                                        <tr>
                                            <td>Website Domain</td>
                                            <td>${ORGANISATION.getOrgDomain()}</td>
                                        </tr>
                                        <tr>
                                            <td>Card Number</td>
                                            <td>${ORGANISATION.getCardNum()}</td>
                                        </tr>
                                        <tr>
                                            <td>Expiry Date</td>
                                            <td>${ORGANISATION.getCardExpiry()}</td>
                                        </tr>
                                        <tr>
                                            <td>CVV</td>
                                            <td>${ORGANISATION.getCardCVV()}</td>
                                        </tr>
                                        <tr>
                                            <td>Business Plan</td>
                                            <td>${ORGANISATION.getOrgPlan()}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Employees Table Tab -->
                    <div class="tab-pane show" id="list-employees" role="tabpanel" aria-labelledby="list-employees-list">
                        <h1 class="mt-4"> ${ORGANISATION.getOrgName()} Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Dashboard</li>
                            <li class="breadcrumb-item active">View Employees</li>
                        </ol>

                        <!-- EMPLOYEE TABLE -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                All Employees
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Gender</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tfoot>
                                        <tr>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Gender</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        </tfoot>
                                        <tbody>
                                        <c:forEach items="${EMPLOYEES}" var="employee">
                                            <tr>
                                                <td>${employee.getFirstName()}</td>
                                                <td>${employee.getLastName()}</td>
                                                <td>${employee.getEmail()}</td>
                                                <td>${employee.getPhone()}</td>
                                                <td>${employee.getGender()}</td>
                                                <td style="text-align: center;">
                                                    <div class="input-group">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-success" onclick="location.href='AccountServlet?action=openedit&userid=${employee.getUserID()}'">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </td>
                                                <td style="text-align: center;">
                                                    <div class="input-group">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-danger" data-href="AccountServlet?action=delete&userid=${employee.getUserID()}" data-toggle="modal" data-target="#confirm-delete" data-whatever="${employee.getFirstName()} ${employee.getLastName()}">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- New Employee Tab -->
                    <div class="tab-pane show" id="list-add" role="tabpanel" aria-labelledby="list-add-list">
                        <h1 class="mt-4"> ${ORGANISATION.getOrgName()} Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Dashboard</li>
                            <li class="breadcrumb-item active">Add New Employee</li>
                        </ol>

                        <!-- NEW EMPLOYEE FORM -->
                        <h3 class="login-heading mb-4">Add a new employee</h3>


                        <!-- New Employee Form -->
                        <form action="AccountServlet" method="POST">
                            <input type="hidden" name="action" value="addEmployee">

                            <!-- ROW -->
                            <div class="form-row">
                                <!-- First Name -->
                                <div class="form-label-group col-md-6">
                                    <input type="text" id="firstname" name="firstname" class="form-control" placeholder="First Name" required autofocus>
                                    <label for="firstname">First Name</label>
                                </div>
                                <!-- Last Name -->
                                <div class="form-label-group col-md-6">
                                    <input type="text" id="lastname" name="lastname" class="form-control" placeholder="First Name" required autofocus>
                                    <label for="lastname">Last Name</label>
                                </div>
                            </div>


                            <!-- Email -->
                            <div class="form-label-group">
                                <input type="email" id="email" name="email" class="form-control" placeholder="Email" required autofocus>
                                <label for="email">Email</label>
                            </div>


                            <!-- ROW -->
                            <div class="form-row">
                                <!-- Phone -->
                                <div class="form-label-group col-md-6">
                                    <input type="number" id="phonenumber" name="phonenumber" class="form-control" placeholder="Phone" required autofocus>
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

                            <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2 col-md-6 mx-auto" type="submit">Continue <i class="fas fa-long-arrow-alt-right"></i></button>
                        </form> <!-- end of add employee -->
                    </div>

                    <!-- Settings Tab -->
                    <div class="tab-pane show" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">
                        <h1 class="mt-4"> ${ORGANISATION.getOrgName()} Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Dashboard</li>
                            <li class="breadcrumb-item active">Settings</li>
                        </ol>

                        <h3 class="login-heading mb-4">Edit Details</h3>

                        <!-- EDIT ORG DETAILS -->
                        <form action="OrganisationServlet" method="POST">
                            <input type="hidden" name="action" value="editOrg">

                            <!-- Name -->
                            <div class="form-label-group">
                                <input type="text" id="orgname" name="orgname" class="form-control" placeholder="Organisation Name" value="${ORGANISATION.getOrgName()}" required autofocus>
                                <label for="orgname">Organisation Name</label>
                            </div>

                            <!-- Email -->
                            <div class="form-label-group">
                                <input type="email" id="orgemail" name="orgemail" class="form-control" placeholder="Email Address" value="${ORGANISATION.getOrgEmail()}" required autofocus>
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
                                <input type="text" id="orgdomain" name="orgdomain" class="form-control" placeholder="Organisation Domain" value="${ORGANISATION.getOrgDomain()}" required autofocus>
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
                                <input type="number" id="orgcardnum" name="orgcardnum" class="form-control" placeholder="Card Number" value="${ORGANISATION.getCardNum()}" required autofocus>
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
                                <input type="number" id="orgcvv" name="orgcvv" class="form-control" placeholder="Card CVV" value="${ORGANISATION.getCardCVV()}" required autofocus>
                                <label for="orgcvv">CVV Number</label>
                            </div>

                            <button class="btn btn-lg btn-primary btn-block btn-login text-uppercase font-weight-bold mb-2 col-md-6 mx-auto" type="submit">Update <i class="fas fa-long-arrow-alt-right"></i></button>
                        </form>



                        <h3 class="login-heading mb-4" style="margin-top: 50px;">Delete Account</h3>

                        <button class="btn btn-lg btn-danger btn-block btn-login text-uppercase font-weight-bold mb-2 col-md-6 mx-auto" data-href="OrganisationServlet?action=deleteOrg" data-toggle="modal" data-target="#confirm-org-delete">
                            Delete Account <i class="fas fa-trash"></i>
                        </button>



                        <p>Changes will cascade to all employees</p>
                        <p>Modal to pop up?</p>

                        <p>Show details of their payment plan, dates payment is due (maybe a loading circle like AWS finance billing tracker).</p>
                        <p>Have other plans</p>
                        <p>MAX EMPLOYEES MUST BE UNDER THE 'business plan' limit!!!!</p>
                    </div>



                    <!-- Message Tab -->
                    <div class="tab-pane show" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
                        <h1 class="mt-4"> ${ORGANISATION.getOrgName()} Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">Dashboard</li>
                            <li class="breadcrumb-item active">Messages</li>
                        </ol>

                        <!-- EMPLOYEE TABLE -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                All Messages
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable3" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>First Name</th>
                                            <th>Last Name</th>
                                            <th>Message</th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${EMPLOYEEMESSAGES}" var="message">
                                            <tr>
                                                <td>${message.getFirstName()}</td>
                                                <td>${message.getLastName()}</td>
                                                <td>Requesting a password reset.</td>
                                                <td style="text-align: center;">
                                                    <div class="input-group">
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-danger" data-href="OrganisationServlet?action=removeMessage&userid=${message.getUserID()}" data-toggle="modal" data-target="#confirm-message-delete">
                                                                <i class="fas fa-amazon"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div> <!-- end of tab -->

                </div>

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

