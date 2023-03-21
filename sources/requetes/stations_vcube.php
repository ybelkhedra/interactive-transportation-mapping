<?php
// <!-- 
// On fait la liste des stations_vcube, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS (pas besoin d'en faire une liste car cela sera un point unique)
// - la liste des arrets a proximites
// -->

$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT stations_vcube.*, latitude, longitude
FROM stations_vcube
INNER JOIN situer_stations_vcube
    ON stations_vcube.id = situer_stations_vcube.station_vcube
INNER JOIN coordonnees_stations_vcube
    ON situer_stations_vcube.coordonnee = coordonnees_stations_vcube.id
;
")) {
    while ($row = $result->fetch_assoc()) {

        $result2 = $db->query("SELECT arrets.nom AS nom FROM arrets INNER JOIN stations_vcube ON arrets.station_vcube_proximite = stations_vcube.id where arrets.station_vcube_proximite = ".$row['id'].";");
        $tab_arrets = array_merge($row, array("arrets_proximite" => array()));

        while ($row2 = $result2->fetch_assoc()) {
            $tab_arrets['arrets_proximite'][] = array("nom" => $row2['nom']);
        }
        $result2->free();

        $stations_vcube[] = $tab_arrets;
    }
    // on libere la memoire
    $result->free();
} else {
    echo "Erreur: " . $db->error;
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($stations_vcube);

$db->close();

?>