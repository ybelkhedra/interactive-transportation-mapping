<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

//afficher les parkings avec leurs emplacements
if ($result = $db->query("SELECT DISTINCT points_de_charges.id, nom, payant, prive, latitude, longitude FROM points_de_charges JOIN emplacement_pdc ON points_de_charges.id = emplacement_pdc.reference JOIN coordonnees_gps ON emplacement_pdc.point = coordonnees_gps.id;")) {
    while ($row = $result->fetch_assoc()) {
        $parkings[] = $row;
    }
    $result->free();
}
echo json_encode($parkings);
?>