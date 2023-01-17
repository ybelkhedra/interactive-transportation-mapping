function addCoordinatesLine(nbCoords) {
    var formLines = document.getElementById("add-coordinates");
    var newLine = document.createElement("div");
    newLine.classList.add("form-line");
    newLine.innerHTML = "<label for='latitude" + nbCoords + "'>Latitude</label>" + "<input type='text' name='latitude" + nbCoords + "' id='latitude" + nbCoords + "' " + "value='44.79517'>" +
    "<label for='longitude" + nbCoords + "'>Longitude</label>" + "<input type='text' name='longitude" + nbCoords + "' id='longitude" + nbCoords + "' " + "value='-0.603537'>"
    + '<input type="button" value="-" class="remove-line-button" onclick="removeCoords(this)">';
    console.log(newLine.innerHTML);
    formLines.appendChild(newLine);
}

function removeCoordinatesLine(el) {
    var formLine = el.parentNode;
    formLine.parentNode.removeChild(formLine);
}