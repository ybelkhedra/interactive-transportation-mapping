<!-- On fait la liste des parkings, avec pour chacun toutes ses informations statiques mais aussi :
- la liste des positions gps qui lui sont associées
- le nombre de points de recharges qui lui sont associés
- le nombre de points de covoiturages qui lui sont associés

-->
<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query("
SELECT parkings.id, parkings.nom, parkings.nb_places_max, parkings.payant, parkings.nb_places_handicapes, parkings.hors_voirie, parkings.prive, parkings.info_complementaires
FROM parkings INNER JOIN situer_parkings ON parkings.id = situer_parkings.parking INNER JOIN coordonnees_parkings ON situer_parkings.coordonnee = coordonnees_parkings.id
;
")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
        
        $row = array_merge($row, array("coordonnees" => array("latitude" => float, "longitude" => float)));
        // on recupere les coordonnees du parking
        $result2 = $db->query("SELECT coordonnees_parkings.latitude AS latitude, coordonnees_parkings.longitude AS longitude FROM coordonnees_parkings INNER JOIN situer_parkings ON situer_parkings.coordonnee = coordonnees_parkings.id WHERE parking = ".$row['id'].";");
        
        while ($row2 = $result2->fetch_assoc()) {
            // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
            $row['coordonnees']['latitude'] = $row2['latitude'];
            $row['coordonnees']['longitude'] = $row2['longitude'];
        }

        $row = array_merge($row, array("nb_pts_recharge" => int));
        // on recupere les points de recharges du parkings
        $result2 = $db->query("SELECT count(*) FROM pts_recharge WHERE parking_correspondant = ".$row['id'].";");
        
        while ($row2 = $result2->fetch_assoc()) {
            $row['points_de_recharge'] = $row2['points_de_recharge'];
        }

        $row = array_merge($row, array("nb_pts_covoiturage" => int));
        // on recupere les points de covoiturage du parkings
        $result2 = $db->query("SELECT count(*) FROM pts_covoiturage WHERE parking_correspondant = ".$row['id'].";");

        while ($row2 = $result2->fetch_assoc()) {
            $row['points_de_covoiturage'] = $row2['points_de_covoiturage'];
        }

        $result2->free();
        // on ajoute la station courante à la liste des stations
        $parkings[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($parkings);

// on ferme la connexion à la base de données
$db->close();

// on termine notre script php
?>