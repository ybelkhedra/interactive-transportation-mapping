<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

//afficher les parkings avec leurs emplacements
if ($result = $db->query("SELECT DISTINCT points_de_covoiturages.id, nom, informations_complementaires, latitude, longitude FROM points_de_covoiturages JOIN emplacement_covoiturage ON points_de_covoiturages.id = emplacement_covoiturage.reference JOIN coordonnees_gps ON emplacement_covoiturage.point = coordonnees_gps.id;")) {
    while ($row = $result->fetch_assoc()) {
        $parkings[] = $row;
    }
    $result->free();
}
echo json_encode($parkings);
?>