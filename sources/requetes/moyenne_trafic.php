<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT *
FROM capteurs
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