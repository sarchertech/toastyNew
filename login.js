function login(keyfob) {
    //console.log(keyfob)
    
    var xhr = new XMLHttpRequest();
    var params = "Fob_num=" + keyfob;
    xhr.open("POST","http://localhost:9000/customer_login",true);

    // Send the proper header information along with the request
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");

    xhr.onreadystatechange = function() {
        if ( xhr.readyState == xhr.DONE) {
            if ( xhr.status == 200) {
                handleResponse(xhr.responseText, keyfob);
            } else {
                console.log("error with login -- Status number is: " + xhr.status)
                displayErr("Oops, something's wrong. Please try again or contact an employee.")
            }
        }
    }
    xhr.send(params);
}

function handleResponse(response, keyfob) {
    //console.log(response)

    var j = JSON.parse(response);

    switch(j["error_code"])
    {
    case 1:
        console.log(j["error_message"] + " keyfob number: " + keyfob)
        displayErr("Oops, something's wrong. Please try again or contact an employee.")
        return
    case 2:
        console.log("customer not found" + " keyfob number: " + keyfob)
        displayErr("Sorry :( We don't recognize that keyfob. Please contact an employee")
        return
    case 3:
        console.log("customer not authorized" + " keyfob number: " + keyfob)
        displayErr("Sorry :( Your account isn't authroized. Please contact an employee.")
        return
    case 4:
        console.log("customer already tanned today" + " keyfob number: " + keyfob)
        displayErr("It looks like you've already tanned today.")
        return
    }

    //console.log(j["name"] + " " + j["level"])
    mainWindow.name = j["name"]
    mainWindow.level = j["level"]
    mainWindow.id = j["id"]
    console.log(mainWindow.name + " " + mainWindow.level)
    pageLoad.source = "pageBeds.qml"
}

function displayErr(errStr) {
    customerError.text = errStr;
    errTimer.running = false;//turn off first, so it doesn't fire prematurely from previous message
    errTimer.running = true;
    customerError.visible = true;
}
