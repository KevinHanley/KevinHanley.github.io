<%--
  Created by IntelliJ IDEA.
  User: kevinhanley
  Date: 19/01/2021
  Time: 2:35 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test Page</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">


    <script type="text/javascript" src="test.js"></script>

</head>
<body>

    <div class="container" style="margin-top: 50px;">
        <div class="page-header">
            <h1>Unsplash API</h1>
        </div>
    </div>

    <div class="container" style="margin-top: 50px;">
        <div class="input-group mb-3">
            <input id="imagesearch" type="text" class="form-control" placeholder="Search Query" aria-label="RSearch Query" aria-describedby="basic-addon2">
            <div class="input-group-append">
                <button onclick="SearchPhotos()" class="btn btn-outline-primary" type="button">Search</button>
            </div>
        </div>

<%--        <input type="text" id="imagesearch" placeholder="search">--%>
<%--        <button onclick="SearchPhotos()">Search</button>--%>
    </div>

    <div class="container" style="margin-top: 50px;">
        <button class="btn btn-outline-primary" onclick="ClearPhotos()">Clear Photos</button>
    </div>

    <div class="container" style="margin-top: 50px;">
        <a href="imageSelection.jsp">Go To Image Selection </a>
    </div>


    <div class="container" style="margin-top: 50px;">
        <h3>Base64 String Test</h3>
        <form action="MyServlet" method="POST">
            <input type="hidden" name="action" value="base">
            <input type="hidden" id="basestring" name="basestring" value="">
            <input type="hidden" id="imageid" name="imageid" value="">

            <button class="btn btn-primary" type="submit">Select after choosing image</button>
        </form>
    </div>


    <div class="container" style="margin-top: 50px;">
        <h3>Unsplash Images</h3>
        <div id="outputimage">
            <!-- images displayed here -->
        </div>
    </div>



    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>

</body>
</html>
