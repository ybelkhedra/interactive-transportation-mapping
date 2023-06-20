<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT capteurs.*, latitude, longitude
FROM capteurs
INNER JOIN situer_capteurs
    ON capteurs.id = situer_capteurs.capteur
INNER JOIN coordonnees_capteurs
    ON situer_capteurs.coordonnee = coordonnees_capteurs.id
;
")) {
    $capteurs = array();
    while ($row = $result->fetch_assoc()) {
        $capteurs[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($capteurs);

$db->close();

?>