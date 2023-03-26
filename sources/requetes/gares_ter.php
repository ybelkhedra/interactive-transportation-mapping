<?php
//On fait la liste des gares_ter, avec pour chacun toutes ses informations statiques mais aussi : 
//- la position GPS pas besoin d'en faire une liste car cela sera un point unique
//-->
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT gares_ter.*, latitude, longitude
FROM gares_ter
INNER JOIN situer_gares_ter
    ON gares_ter.id = situer_gares_ter.gare_ter
INNER JOIN coordonnees_gares_ter
    ON situer_gares_ter.coordonnee = coordonnees_gares_ter.id
;
")) {
    $parkings = array();
    while ($row = $result->fetch_assoc()) {
        $parkings[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($parkings);

$db->close();

?>