<?php

// <!-- 
// On fait la liste des points de charges, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS (pas besoin d'en faire une liste car cela sera un point unique) 
// - la liste des types de prise qui lui sont associés
// - la puissance des prisess qui lui sont associées
// -->


$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT pts_recharge.*, latitude, longitude
FROM pts_recharge
INNER JOIN situer_pts_recharge
    ON pts_recharge.id = situer_pts_recharge.point_de_recharge
INNER JOIN coordonnees_pts_recharge
    ON situer_pts_recharge.coordonnee = coordonnees_pts_recharge.id
;
")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {

        $row = array_merge($row, array("type_prise" => array()));
        $row = array_merge($row, array("puissance" => array()));

        $result2 = $db->query("SELECT types_de_prises.nom as type_prise FROM compatible INNER JOIN types_de_prises ON compatible.type_de_prise = types_de_prises.id WHERE point_de_recharge = ".$row['id'].";");
        $result3 = $db->query("SELECT puissances.puissance as puissance FROM recharger INNER JOIN puissances ON recharger.puissance = puissances.id WHERE point_de_recharge = ".$row['id'].";");
        
        while ($row2 = $result2->fetch_assoc()) {
            $row['type_prise'][] = $row2['type_prise'];
        }

        while ($row3 = $result3->fetch_assoc()) {
            $row['puissance'][] = $row2['puissance'];
        }

        $result2->free();
        $result3->free();

        $parkings[] = $row;
    }

    $result->free();
}
echo json_encode($parkings);

$db->close();

?>

