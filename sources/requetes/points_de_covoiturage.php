<!-- 
    On fait la liste des points de covoiturage, avec pour chacun toutes ses informations statiques mais aussi : 
- la position GPS (pas besoin d'en faire une liste car cela sera un point unique) 
-->

<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT pts_covoit.*, latitude, longitude
FROM pts_covoit 
INNER JOIN situer_pts_covoit
    ON pts_covoit.id = situer_pts_covoit.point_de_covoiturage
INNER JOIN coordonnees_pts_covoit
    ON situer_pts_covoit.coordonnee = coordonnees_pts_covoit.id
;
")) {
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