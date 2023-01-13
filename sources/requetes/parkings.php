<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

//$parkings = $db->query("SELECT DISTINCT parkings.id, nom, latitude, longitude FROM parkings JOIN emplacements_parkings ON parkings.id = emplacements_parkings.reference JOIN coordonnees_gps ON emplacements_parkings.point = coordonnees_gps.id;");

//afficher les parkings avec leurs emplacements
if ($result = $db->query("SELECT DISTINCT parkings.id, nom, nb_places, payant, handicape, hors_voirie, informations_complementaires, latitude, longitude FROM parkings JOIN emplacements_parkings ON parkings.id = emplacements_parkings.reference JOIN coordonnees_gps ON emplacements_parkings.point = coordonnees_gps.id;")) {
    while ($row = $result->fetch_assoc()) {
        $parkings[] = $row;
    }
    $result->free();
}
echo json_encode($parkings);
?>