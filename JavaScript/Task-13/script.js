document.getElementById("regForm").addEventListener("submit", function(event) {

    event.preventDefault();

    console.log("Form submitted");

    let name = document.getElementById("name").value;
    let email = document.getElementById("email").value;

    console.log("Name:", name);
    console.log("Email:", email);

    if(name === "" || email === "") {

        console.error("Validation Failed");

        document.getElementById("message").innerHTML =
            "Please fill all fields";

        return;
    }

    fetch("https://jsonplaceholder.typicode.com/posts", {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify({
            name: name,
            email: email
        })

    })

    .then(response => response.json())

    .then(data => {

        console.log("Server Response:", data);

        document.getElementById("message").innerHTML =
            "Registration Successful";

    })

    .catch(error => {

        console.error("Fetch Error:", error);

    });

});