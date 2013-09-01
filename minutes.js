//TODO fix upperbound so it can't go past the max minutes or below
function updateSlider() {
    var n = Math.floor((point1.x-15)/minutes.mWidth);

    if (!(minutes.selected === n)) {
        minutes.selected = n;
        //console.log(n+2);
        sessionText.text = "START " + (n + 2) + " MINUTE SESSION";
        mainWindow.minutesSelected = n + 2

        //TODO this will be slow. Change it so that it only happens once.
        effect.visible = true;
        startTouch.visible = true;

        //turn off all above pressed
        for(var i=n+1; i<minutes.children.length-1; i++) {
            minutes.children[i].orange = false;
        }

        //turn on all below
        for(var i=0; i<n+1; i++) {
            minutes.children[i].orange = true;
        }
    }
}

function startBed() {
    startTmak(mainWindow.bedSelected,mainWindow.minutesSelected,mainWindow.id)
    gray.visible = true;
    popup.visible = true;
    timer.start();

    popupText.text = "Bed " + mainWindow.bedSelected +
            " will start in 5 minutes."
}

function startTmak(bedNum, minutes, cust_num) {
    var xhr = new XMLHttpRequest();
    var params = "bed_num=" + bedNum + "&" + "time=" + minutes + "&"
            + "cust_num=" + cust_num
    xhr.open("POST","http://localhost:9000/start_bed",true);

    // Send the proper header information along with the request
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");

    xhr.onreadystatechange = function() {
        if ( xhr.readyState == xhr.DONE) {
            if ( xhr.status == 200) {
                handleResponse(xhr.responseText);
            } else {
                console.log("error with getBedsByLevel--status: "+xhr.status );
            }
        }
    }
    xhr.send(params);
}

function handleResponse(string) {
    var err = JSON.parse(string)["error"]

    if (err) {
        console.log(err);
    } else {
        console.log("Bed Started")
    }
}

