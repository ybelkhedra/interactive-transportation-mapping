<!-- 
    On fait la liste des points de charges, avec pour chacun toutes ses informations statiques mais aussi : 
- la position GPS (pas besoin d'en faire une liste car cela sera un point unique) 
- la liste des types de prise qui lui sont associés
- la puissance des prisess qui lui sont associées
-->

<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
// A COMPLETER !!!!!!!
if ($result = $db->query("
SELECT pts_recharge.*, latitude, longitude, types_de_prises.nom as type_de_prise, puissances.puissance as puissance
FROM pts_recharge
INNER JOIN situer_pts_recharge
    ON pts_recharge.id = situer_pts_recharge.point_de_recharge
INNER JOIN coordonnees_pts_recharge
    ON situer_pts_recharge.coordonnee = coordonnees_pts_recharge.id
INNER JOIN compatible
    ON pts_recharge.id = compatible.point_de_recharge
INNER JOIN types_de_prises
    ON compatible.type_de_prise = types_de_prises.id
INNER JOIN recharger
    ON pts_recharge.id = recharger.point_de_recharge
INNER JOIN puissances
    ON recharger.puissance = puissances.id
;
")) {
    while ($row = $result->fetch_assoc()) {
        $pts_recharge[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($pts_recharge);

$db->close();

?>