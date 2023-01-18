function addCoordinatesLine(nbCoords) {
    var formLines = document.getElementById("add-coordinates");
    var newLine = document.createElement("div");
    newLine.classList.add("form-line");
    newLine.innerHTML = "<label for='latitude'>Latitude</label>" + "<input type='text' name='latitude' id='latitude" + nbCoords + "' " + "value='44.79517'>" +
    "<label for='longitude'>Longitude</label>" + "<input type='text' name='longitude' id='longitude" + nbCoords + "' " + "value='-0.603537'>"
    + '<input type="button" value="-" class="remove-line-button" onclick="removeCoords(this)">';
    console.log(newLine.innerHTML);
    formLines.appendChild(newLine);
}

function removeCoordinatesLine(el) {
    var formLine = el.parentNode;
    formLine.parentNode.removeChild(formLine);
}