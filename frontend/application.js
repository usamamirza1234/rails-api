let auth = ""
function getBlogs(){
    var xhttp = new XMLHttpRequest()
    xhttp.onreadystatechange = function ()
    {
        if (this.readyState == 4 && this.status == 200){
            let container =  document.getElementById("container");
            let responses = JSON.parse(this.responseText)
            let data = responses.data
            for (var i=0; i < data.length; i++)
            {
                container.insertAdjacentHTML(
                    "beforeend",
                    createResponse(responses.data[i])
                )
            }
        }
    };
    xhttp.open("GET", "http://localhost:3000/api/v1/blogs",true)
    xhttp.send();
}


window.sendBlogForm =  function(event){
    event.preventDefault();
    var xhttp = new XMLHttpRequest()
    xhttp.open("POST","http://localhost:3000/api/v1/blogs",true);
    xhttp.onload =  function (event){
        let container =  document.getElementById("container");
        let responses = JSON.parse(this.responseText)
        console.log(this.responseText)
        window.responseText = this.responseText
        container.insertAdjacentHTML(
            "beforeend",
            createResponse(responses.data)
        )
    }
    var formData = new this.FormData(document.getElementById('form_blog'));
    xhttp.setRequestHeader( "Authorization", "Bearer " + auth)
    xhttp.send(formData);
}

window.sendForm =  function(event){
    event.preventDefault();
    var xhttp = new XMLHttpRequest()
    xhttp.open("POST","http://localhost:3000/api/v1/sign_up",true);
    xhttp.onload =  function (event){
        let user =  document.getElementById("user");
        let responses = JSON.parse(this.responseText)
        user.insertAdjacentHTML(
            "beforeend",
            "Name: "+ responses.data.user.user_name + " <br/>" +
            "Email: "+ responses.data.user.user_email + " <br/>"
        )

    }

    var formData = new this.FormData(document.getElementById('form'));
    xhttp.send(formData);
}

window.sendSignInForm =  function(event){
    // alert("mssg")
    event.preventDefault();
    var xhttp = new XMLHttpRequest()
    xhttp.open("POST","http://localhost:3000/api/v1/sign_in",true);
    xhttp.onload =  function (event){
        let user =  document.getElementById("user");
        let responses = JSON.parse(this.responseText)
        user.insertAdjacentHTML(
            "beforeend",
            "Name: "+ responses.data.user.user_name + " <br/>" +
            "Email: "+ responses.data.user.user_email + " <br/>"+
            "Token: "+ responses.data.user.token + " <br/>"
        )
        auth = responses.data.user.token
    }

    var formData = new this.FormData(document.getElementById('form_sign_in'));
    xhttp.send(formData);
}

getBlogs()


function createResponse(response)
{
    return (
        `<div class="task"  id="${response.id}" onclick="deleteResponse(${response.id})">` +
            response.id +": " + response.heading +
        "<br></div>"
    )
}

function deleteResponse(response_id){
    var xhttp = new XMLHttpRequest()
    xhttp.open("DELETE", `http://localhost:3000/api/v1/blogs/${response_id}`,true)
    xhttp.onload = function (){
        let responses = JSON.parse(this.responseText)
        // console.log(responses)
        if (responses.status == "ok"){
            let target = document.getElementById(response_id)
            target.parentNode.removeChild(target)
        }
        else
        {
            alert("Token is required")
        }

    };
    xhttp.setRequestHeader( "Authorization", "Bearer " + auth)
    xhttp.send(null)
}