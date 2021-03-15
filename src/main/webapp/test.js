function SearchPhotos(){

    //clear div: https://stackoverflow.com/questions/2554149/html-javascript-change-div-content
    //fetching json code adapted from: https://www.youtube.com/watch?v=zDhVHPRzW6I
    //create an image tag and putting it into a div: https://stackoverflow.com/questions/7802744/adding-an-img-element-to-a-div-with-javascript
    //img onclick: https://stackoverflow.com/questions/23331873/html-img-onclick-javascript
    //border around image: https://stackoverflow.com/questions/47338068/create-border-around-image-when-clicked-in-javascript/47339609
    //convert blob to base64 string: https://stackoverflow.com/questions/18650168/convert-blob-to-base64
    //fetching url to get BLOB: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch#checking_that_the_fetch_was_successful
    //Loading image when results are fetched :https://stackoverflow.com/questions/53799108/how-to-add-a-loading-animation-while-fetch-data-from-api-vanilla-js
    //Bootstrap Spinner: https://getbootstrap.com/docs/4.4/components/spinners/

    //clear the current photos in the div
    document.getElementById("outputimage").innerHTML = "";

    //my access key
    let key = "_Gu7_21w9rctJAQ37rrgNIRG8cQ0BVe6mhArJLFgcH4";

    //obtain search query
    let query = document.getElementById("imagesearch").value;

    //number of results to be returned
    let perpage = "30";

    //the url where data will be fetched from
    let url = "https://api.unsplash.com/search/photos?client_id=" + key + "&query=" + query + "&per_page=" + perpage;

    //Set a spinner to display when results are being fetched
    let loader = `<div class="d-flex justify-content-center">
                      <div class="spinner-border m-5" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                      </div>
                    </div>`;
    document.getElementById('outputimage').innerHTML = loader;

    //get the image data and display the results
    fetch(url)
        .then(function(data){
            return data.json(); // get the data in JSON format
        })
        .then(function(data){

            document.getElementById("outputimage").innerHTML = "";

            //loop through each "photo"
            data.results.forEach(photo =>{

                // let rowdiv = document.createElement("div");
                // rowdiv.classList.add("col-md-4");

                //get the path to the "small" size image from the data set
                let link = photo.urls.small;
                let id = photo.id;

                //create an <img> and assign attributes
                let elem = document.createElement("img");
                elem.src = link;
                elem.setAttribute("id", id);
                elem.setAttribute("height", "200");
                //elem.setAttribute("width", "200");
                elem.style.margin = "5px";
                elem.classList.add("image-hover");
                elem.setAttribute("onclick", "DoActions(this.id)");

                // rowdiv.appendChild(elem);
                //document.getElementById("outputimage").appendChild(rowdiv);

                //Add the image to the div
                document.getElementById("outputimage").appendChild(elem);
            })
        })
}

function ClearPhotos(){
    document.getElementById("outputimage").innerHTML = "";
}

function DoActions(id){

    //Remove ".imageSelected" from previously selected images
    var elems = document.querySelectorAll(".imageSelected");
    [].forEach.call(elems, function(el) {
        el.classList.remove("imageselected");
    });

    var element = document.getElementById(id);
    element.classList.add("imageselected");

    //Base 64 Test
    let url = document.getElementById(id).src;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.blob();
        })
        .then(myBlob => {

            //convert the blob to base 64 string
            var reader = new FileReader();
            reader.readAsDataURL(myBlob);
            reader.onloadend = function() {
                var base64data = reader.result;

                //Assign this Base64 String to the hidden field in the form.
                document.getElementById("basestring").value = base64data;
                document.getElementById("imageid").value = id;
                document.getElementById("searchUpload").disabled = false;
            }

        })
        .catch(error => {
            console.error('There has been a problem with the fetch operation1:', error);
        });

    //Hit the download API
    //Triggering a download: https://help.unsplash.com/en/articles/2511258-guideline-triggering-a-download
    //How to make requests: https://www.freecodecamp.org/news/here-is-the-most-popular-ways-to-make-an-http-request-in-javascript-954ce8c95aaa/

    //my access key
    let key = "_Gu7_21w9rctJAQ37rrgNIRG8cQ0BVe6mhArJLFgcH4";
    let download_url = "https://api.unsplash.com/photos/" + id + "/download?client_id=" + key;

    fetch(download_url)
        .then(data => {
            return data.json();
        })
        .then(rdata => {
            console.log(rdata)
        })
        .catch(error => {
            console.error('There has been a problem with the fetch operation2:', error);
        });
}

function uploadForms(){

    //submit outside of form: https://stackoverflow.com/questions/7020659/submit-form-using-a-button-outside-the-form-tag/12567605#12567605
    //check form empty: https://stackoverflow.com/questions/25793880/how-to-check-if-input-file-is-empty-in-jquery

    //check if a file was uploaded.
    if( document.getElementById("upload").files.length == 0 ){

        //check if an image was searched for instead
        if( document.getElementById("imageid").value.length == 0 ){
            //do nothing

        }else{
            //submit the form
            document.getElementById("searchForm").submit();

        }

    }else{
        //submit the form
        document.getElementById("uploadForm").submit();

    }

}

function checkPassword(){

    //Submit the form
    document.getElementById("tileForm").submit();

}

function createPassword(){

    //Submit the form
    document.getElementById("tileForm2").submit();

}

function confirmPassword(){

    //Submit the form
    document.getElementById("tileForm3").submit();

}