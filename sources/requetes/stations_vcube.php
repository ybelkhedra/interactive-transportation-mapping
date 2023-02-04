<?php
// <!-- 
// On fait la liste des stations_vcube, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS (pas besoin d'en faire une liste car cela sera un point unique)
// - la liste des arrets a proximites
// -->

$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT stations_vcube.*, latitude, longitude, GROUP_CONCAT(arrets.nom SEPARATOR ', ') as arrets_proximite
FROM stations_vcube
INNER JOIN situer_stations_vcube
    ON stations_vcube.id = situer_stations_vcube.station_vcube
INNER JOIN coordonnees_stations_vcube
    ON situer_stations_vcube.coordonnee = coordonnees_stations_vcube.id
LEFT JOIN arrets
    ON stations_vcube.id = arrets.station_vcube_proximite
;
")) {
    while ($row = $result->fetch_assoc()) {
        $stations_vcube[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($stations_vcube);

$db->close();

?>