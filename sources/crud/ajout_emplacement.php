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
            document.getElementById("latitude").value = e.latlng.lat;
            document.getElementById("longitude").value = e.latlng.lng;
        });

</script>

<?php

// bouton pour valider l'ajout de coordonnée
echo "<form action='ajout_emplacement.php' method='post'>";
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
echo "<br>";
echo "<input type='hidden' name='ajout' value='oui'>";
echo "<input type='submit' value='Ajouter'>";
echo "</form>";

// si le bouton est cliqué
if (isset($_POST['ajout'])) {
    $conn = mysqli_connect("localhost", $_POST['user'], $_POST['password'], $_POST['database']);

    echo "ajout en cours ...";
    // recupere les coordonnées
    $latitude = $_POST['latitude'];
    $longitude = $_POST['longitude'];
    // ajoute les coordonnées dans la table coordonnees_gps
    $sql1 = "INSERT INTO coordonnees_gps (latitude, longitude) VALUES ('$latitude', '$longitude');";
    echo $sql1;
    if (mysqli_query($conn, $sql1)) {
        echo "New record created successfully";

        // recupere l'id de la derniere coordonnée ajoutée
        $last_id_gps = mysqli_insert_id($conn);
        echo "id de la derniere coordonnée ajoutée : $last_id_gps";
        echo "TABLE : $table";
        if ($table == "parkings")
        {
            $table_corespondance = "emplacements_parkings";
        }
        else if ($table == "points_de_charges")
        {
            $table_corespondance = "emplacement_pdc";
        }
        else if ($table == "stationnement_velo")
        {
            $table_corespondance = "emplacement_stationnement_velo";
        }
        else if ($table == "points_de_covoiturages")
        {
            $table_corespondance = "emplacement_covoiturage";
        }
        $last_id = $_POST['id_table'];
        echo "id de la derniere entrée dans parking ajoutée : $last_id";
        // ajoute l'id de la coordonnée dans la table emplacement
        $sql2 = "INSERT INTO $table_corespondance (point, reference) VALUES ('$last_id_gps', '$last_id');";
        echo $sql2;
        if (mysqli_query($conn, $sql2)) {
            echo "New record created successfully";
        } else {
            echo "Error: " . $sql . "<br>" . mysqli_error($conn);
        }
        //bouton retour vers crud post info de conneciton

    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }

    echo "<form action='crud.php' method='post'>";
    echo "<input type='hidden' name='user' value='$user'>";
    echo "<input type='hidden' name='password' value='$password'>";
    echo "<input type='hidden' name='database' value='$database'>";
    echo "<input type='hidden' name='table' value='$table'>";
    echo "<input type='submit' value='Retour'>";
}



?>

</body>