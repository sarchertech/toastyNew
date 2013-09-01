function tabPressed(index) {
    tabs.children[tabs.tabIndex].color = "#56A2D6"
    tabs.tabIndex = index;
    tabs.children[tabs.tabIndex].color = "#9AC7E6";

    getBedsByLevel(index+1)
}

function getBedsByLevel(bedNum) {
    var xhr = new XMLHttpRequest();
    var params = "Level=" + bedNum
    xhr.open("POST","http://localhost:9000/bed_status",true);

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
    var bedJSON = JSON.parse(string)["beds"]//parseJSON(string);

    //build model from customer JSON data
    beds.model = bedJSON;
}
