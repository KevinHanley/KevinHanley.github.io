<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 24/11/2020
  Time: 1:52 p.m.
  To change this template use File | Settings | File Templates.
--%>



<!-- Collapsing divs when button is clicked on: https://stackoverflow.com/questions/11476670/bootstrap-collapse-other-sections-when-one-is-expanded-->


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<html>
<head>
    <title>Choose Image</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <!-- jQuery that works -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/8e47f0960d.js" crossorigin="anonymous"></script>

    <!-- JavaScript for the Unsplash API -->
    <script type="text/javascript" src="test.js"></script>

    <!-- style sheets -->
    <link rel="stylesheet" href="styles/image.css" type="text/css"/>

    <script type="text/javascript">
        $(document).ready(function(){

            $('#listBrowse').addClass('active bg-primary text-white shadow-sm');
            $('#browseSection').collapse('show');

            //close the other collapsible div, when one is clicked.
            $('#listBrowse').click(function (e){
                $('.collapse').collapse('hide');
                $(this).addClass('active bg-primary text-white shadow-sm');
                $('#listSearch').removeClass('active bg-primary text-white shadow-sm');
            });

            $('#listSearch').click(function (e){
                $('.collapse').collapse('hide');
                $(this).addClass('active bg-primary text-white shadow-sm');
                $('#listBrowse').removeClass('active bg-primary text-white shadow-sm');
            });

            $('#imagesearch').keyPress(function (e) {
                if (e.which === 13) {
                    alert("Hello");
                    e.preventDefault();
                    return false;

                }
            });


            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#imageResult')
                            .attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(function () {
                $('#upload').on('change', function () {
                    readURL(input);
                });
            });

            /*  ==========================================
                SHOW UPLOADED IMAGE NAME
            * ========================================== */
            var input = document.getElementById( 'upload' );
            var infoArea = document.getElementById( 'upload-label' );

            input.addEventListener( 'change', showFileName );
            function showFileName( event ) {
                var input = event.srcElement;
                var fileName = input.files[0].name;
                infoArea.textContent = 'File name: ' + fileName;
            }
        });
    </script>



</head>
<body>

<!-- Links:
    Collapse Buttons: https://getbootstrap.com/docs/4.0/components/collapse/
    Side Bar Nav: https://bootstrapious.com/p/bootstrap-vertical-menu
    Image Upload: https://bootstrapious.com/p/bootstrap-image-upload
    Quotes in placeholder: https://stackoverflow.com/questions/53582916/quotation-marks-in-textarea-placeholder
-->

<header>
    <div class="overlay">
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: transparent;">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <button class="btn btn-lg btn-primary btn-block btn-upload text-uppercase font-weight-bold mb-2" onclick="uploadForms()" type="button" >Upload  <i class="fas fa-upload"></i></button>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>


<section>
    <div class="container-fluid">
        <div class="rounded">
            <div class="row h-100">
                <div class="col-lg-3 mb-3 mb-lg-0">
                    <div class="align-items-center">
                        <nav class="nav flex-column align-self-center bg-light shadow-sm font-italic rounded p-3">
                            <h3 class="login-heading mb-4">Upload an image:</h3>
                            <a id="listBrowse" class="nav-link px-4 rounded-pill" data-toggle="collapse" href="#browseSection" role="button" aria-expanded="false" aria-controls="browseSection">
                                <i class="fas fa-desktop mr-2"></i>
                                Browse Your Device
                            </a>
                            <a id="listSearch" class="nav-link px-4 rounded-pill" data-toggle="collapse" href="#searchSection" role="button" aria-expanded="false" aria-controls="searchSection">
                                <i class="fas fa-search mr-2"></i>
                                Find Online
                            </a>
                        </nav>
                    </div>
                </div>

                <div class="col-lg-9 mb-6">

                    <!-- ********** -->
                    <!-- Browse Section-->
                    <!-- ********** -->

                    <div class="collapse" id="browseSection">
                        <%--                        <form action="ImageServlet" method="POST" enctype="multipart/form-data">--%>
                        <%--                            <input type="hidden" name="imageaction" value="upload">--%>

                        <%--                            <div class="input-group mb-3">--%>
                        <%--                                <div class="custom-file">--%>
                        <%--                                    <input type="file" class="custom-file-input" id="myFile" name="file" accept="image/jpeg" onchange="document.getElementById('display').src = window.URL.createObjectURL(this.files[0]); document.getElementById('deviceUpload').disabled = false">--%>
                        <%--                                    <label class="custom-file-label" for="myFile" aria-describedby="myFile">Choose file</label>--%>
                        <%--                                </div>--%>
                        <%--                                <div class="input-group-append">--%>
                        <%--                                    <button class="btn btn-primary" type="submit" id="deviceUpload" disabled>Upload</button>--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>


                        <%--                        </form>--%>

                        <%--                        <h5>Preview of your image:</h5>--%>
                        <%--                        <img id="display" alt="Image Preview" width="500" height="500" style="margin-bottom: 50px;" />--%>


                        <!-- Upload image input-->
                        <form id="uploadForm" action="ImageServlet" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="imageaction" value="upload">

                            <!-- upload box -->
                            <div class="input-group mb-3 px-2 py-2 rounded-pill bg-white shadow-sm">
                                <input id="upload" type="file" onchange="readURL(this);" class="form-control border-0" name="file" accept="image/jpeg">
                                <label id="upload-label" for="upload" class="font-weight-light text-muted">Choose file</label>
                                <div class="input-group-append">
                                    <label for="upload" class="btn btn-light m-0 rounded-pill px-4"> <i class="fa fa-cloud-upload mr-2 text-muted"></i><small class="text-uppercase font-weight-bold text-muted">Choose file</small></label>
                                </div>
                            </div>
                        </form>


                        <!-- Uploaded image area-->
                        <p class="font-italic text-center">The image uploaded will be rendered inside the box below.</p>
                        <div id="image-area" class="mt-4"><img id="imageResult" src="#" alt="" class="img-fluid rounded shadow-sm mx-auto d-block"></div>
                    </div>


                    <!-- ********** -->
                    <!-- Search Section-->
                    <!-- ********** -->

                    <div class="collapse" id="searchSection">

                        <%--                        <div class="container">--%>
                        <%--                            <div class="input-group mb-3">--%>
                        <%--                                <input id="imagesearch" type="text" class="form-control" placeholder="Search Query" aria-label="Search Query" aria-describedby="basic-addon2">--%>
                        <%--                                <div class="input-group-append">--%>
                        <%--                                    <button onclick="SearchPhotos()" class="btn btn-outline-primary" type="button">Search</button>--%>
                        <%--                                </div>--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>

                        <%--                        <div class="container" style="margin-top: 50px;">--%>
                        <%--                            <form action="ImageServlet" method="POST">--%>
                        <%--                                <input type="hidden" name="imageaction" value="apiUpload">--%>
                        <%--                                <input type="hidden" id="basestring" name="basestring" value="">--%>
                        <%--                                <input type="hidden" id="imageid" name="imageid" value="">--%>

                        <%--                                <button class="btn btn-primary" type="submit" id="searchUpload" disabled>Upload</button>--%>
                        <%--                            </form>--%>
                        <%--                        </div>--%>

                        <%--                        <div class="container-fluid" style="margin-top: 50px; margin-bottom: 50px;">--%>
                        <%--                            <h3>Search Results</h3>--%>
                        <%--                            <div id="outputimage">--%>
                        <%--                                <!-- images displayed here -->--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>

                        <form id="searchForm" action="ImageServlet" method="POST">
                            <input type="hidden" name="imageaction" value="apiUpload">
                            <input type="hidden" id="basestring" name="basestring" value="">
                            <input type="hidden" id="imageid" name="imageid" value="">

                            <div class="p-1 bg-light rounded rounded-pill shadow-sm mb-4">
                                <div class="input-group">
                                    <input type="search" placeholder="Try searching for &quot;Mountains&quot; or &quot;Summer&quot;" aria-describedby="button-addon1" class="form-control border-0 bg-light" id="imagesearch">
                                    <div class="input-group-append">
                                        <button id="button-addon1" type="button" class="btn btn-link text-primary" onclick="SearchPhotos()"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <div class="container-fluid" style="margin-top: 50px; margin-bottom: 50px;">
                            <h3>Search Results</h3>
                            <!-- maybe add: class="d-flex flex-wrap" below? -->
                            <div id="outputimage">
                                <!-- images displayed here -->
                            </div>
                        </div>

                    </div> <!-- end of collapse -->

                </div> <!-- end -->
            </div>
        </div>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
</body>
</html>