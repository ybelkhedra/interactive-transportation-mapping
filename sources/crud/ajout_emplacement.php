<!DOCTYPE html>
<html>

<head>

<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <script>
        L_NO_TOUCH = false;
        L_DISABLE_3D = false;
    </script>
    <style>html, body {width: 100%;height: 100%;margin: 0;padding: 0;}</style>
    <style>#map {position:absolute;top:0;bottom:0;right:0;left:0;}</style>
    <script src="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.js"></script>
    <script src="../addCoordinatesLine.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/python-visualization/folium/folium/templates/leaflet.awesome.rotate.min.css"/>
                <meta name="viewport" content="width=device-width,
            initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <style>
            #map {
                position: absolute;
                width: 100%;
                height: 70%;
                top: 20%;
            }
        </style>    

</head>

<body>

<script>
    var nbCords = 1;
    function addCoords() {
        addCoordinatesLine(nbCords);
        ++nbCords;
    }

    function removeCoords(el) {
        if (nbCords > 1) {
            removeCoordinatesLine(el);
            --nbCords;
        }
    }

    function getNbCords() {
        return nbCords;
    }

    function resetNbCoords() {
        nbCords = 1;
    }
</script>

<?php
//recupere info de connection
$user = $_POST['user'];
$password = $_POST['password'];
$database = $_POST['database'];
$table = $_POST['table'];
$last_id = $_POST['id_table'];
$latitude = 0;
$longitude = 0;
?>


<!-- ajouter une carte leaflet.js dans un conteneur -->
<div>
        <div id="map"></div>
</div>


<script>
        var map = L.map('map').setView([44.79517,-0.603537], 13);
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        // Add a marker to the map
        var marker = L.marker([44.79517,-0.603537]).addTo(map);

        // Listen for clicks on the map
        map.on('click', function(e) {
            // Update the marker position
            //console.log(e);
            marker.setLatLng(e.latlng);
        
            // fill the form inputs with the coordinates
            if (getNbCords() == 1) {
                document.getElementById("latitude").value = e.latlng.lat;
                document.getElementById("longitude").value = e.latlng.lng;
            } else {
                i = getNbCords() - 1;
                document.getElementById("latitude" + i).value = e.latlng.lat;
                document.getElementById("longitude" + i).value = e.latlng.lng;
            }
        });

</script>

<?php

// bouton pour valider l'ajout de coordonnée
echo "<form action='ajout_emplacement.php' method='post'>";
echo "<div id = 'add-coordinates'>";
echo "<div class='form-line'>";
echo "<input type='hidden' name='user' value='$user'>";
echo "<input type='hidden' name='password' value='$password'>";
echo "<input type='hidden' name='database' value='$database'>";
echo "<input type='hidden' name='table' value='$table'>";
echo "<input type='hidden' name='id_table' value='$last_id'>";
echo "<br>";
echo "<label for='latitude'>Latitude</label>";
echo "<input type='text' name='latitude' id='latitude' value='44.79517'>";
echo "<label for='longitude'>Longitude</label>";
echo "<input type='text' name='longitude' id='longitude' value='-0.603537'>";
echo "</div>";
echo "</div>";
echo "<input type='button' value='+' id='add-coordinates-button' onClick = 'addCoords()'>";
echo "<br>";
echo "<input type='hidden' name='ajout' value='oui'>";
echo "<input type='submit' value='Ajouter'>";
echo "</form>";

// si le bouton est cliqué
if (isset($_POST['ajout'])) {
    $conn = mysqli_connect("localhost", $_POST['user'], $_POST['password'], $_POST['database']);

    // recupere les coordonnées
    $latitude = $_POST['latitude'];
    $longitude = $_POST['longitude'];

    $sql1 = "INSERT INTO coordonnees_".$table." (latitude, longitude) VALUES ('$latitude', '$longitude');";
    
    $table_corespondance = "situer_".$table;

    // ajoute les coordonnées dans la table coordonnees_gps


    $k = 0;

    echo $_POST['latitude1'];
    echo $_POST['longitude1'];
    echo $_POST['latitude'];
    
    while (isset($_POST['latitude'.$k]) || $k == 0) {
        if (mysqli_query($conn, $sql1)) {

            echo 'latitude' . $k;

            if ($k > 0 ){
                $latitude = $_POST['latitude'.$k];
                $longitude = $_POST['longitude'.$k];
            }

            $k++;

            echo "New record created successfully";

            // recupere l'id de la derniere coordonnée ajoutée
            $last_id_gps = mysqli_insert_id($conn);

            $last_id = $_POST['id_table'];

            //recuperer le nom des champs de la table_corespondance dans l'ordre de la table et dire que point est le premier champ
            $sql3 = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '$database' AND TABLE_NAME = '$table_corespondance' ORDER BY ORDINAL_POSITION";
            // echo $sql3;
            $result = mysqli_query($conn, $sql3);
            $row = mysqli_fetch_array($result);
            // echo "1 : ".$row[0];
            $row = mysqli_fetch_array($result);
            // echo "2 : ".$row[0];
            $point = $row[0];
            $reference = "coordonnee";



            // ajoute l'id de la coordonnée dans la table emplacement
            $sql2 = "INSERT INTO $table_corespondance (".$point.", ".$reference.") VALUES ('$last_id', '$last_id_gps');";
            echo $sql2;
            if (mysqli_query($conn, $sql2)) {
                echo "New record created successfully";
            } else {
                echo "Error: " . $sql . "<br>" . mysqli_error($conn);
            }
        } else {
            echo "Error: " . $sql . "<br>" . mysqli_error($conn);
        }
    }

    echo "<form action='crud.php' method='post'>";
    echo "<input type='hidden' name='user' value='$user'>";
    echo "<input type='hidden' name='password' value='$password'>";
    echo "<input type='hidden' name='database' value='$database'>";
    echo "<input type='hidden' name='table' value='$table'>";
    //bouton retour vers crud post info de conneciton
    echo "<input type='submit' value='Retour'>";
}



?>

</body>