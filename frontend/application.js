function getBlogs(){
    var xhttp = new XMLHttpRequest()
    xhttp.onreadystatechange = function ()
    {
        if (this.readyState == 4 && this.status == 200){
            let container =  document.getElementById("container");
            let responses = JSON.parse(this.responseText)
            window.responses= JSON.parse(this.responseText)
            console.log(this.responseText)
            window.responseText = this.responseText
            // alert(this.responseText)

            let data = responses.data

            for (var i=0; i < data.length; i++)
            {
                container.insertAdjacentHTML(
                    "beforeend",
                    i+1 + ": " + responses.data[i].heading + " <br/>"
                )
            }

        }
    };
    xhttp.open("GET", "http://localhost:3000/api/v1/blogs",true)
    xhttp.send();
}

window.sendForm =  function(event){
    // alert("mssg")
    event.preventDefault();
    var xhttp = new XMLHttpRequest()
    xhttp.open("POST","http://localhost:3000/api/v1/sign_up",true);
    xhttp.onload =  function (event){
        let user =  document.getElementById("user");
        let responses = JSON.parse(this.responseText)
        console.log(this.responseText)
        window.responseText = this.responseText


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
        console.log(this.responseText)
        window.responseText = this.responseText


        user.insertAdjacentHTML(
            "beforeend",
            "Name: "+ responses.data.user.user_name + " <br/>" +
            "Email: "+ responses.data.user.user_email + " <br/>"+
            "Token: "+ responses.data.user.token + " <br/>"
        )

    }

    var formData = new this.FormData(document.getElementById('form_sign_in'));
    xhttp.send(formData);
}

getBlogs()