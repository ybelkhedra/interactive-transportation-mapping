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
        
        $row = array_merge($row, array("points_de_recharge" => array()));
        // on recupere les points de recharges du parkings
        $result2 = $db->query("SELECT pts_recharge.id as points_de_recharge FROM pts_recharge, parkings WHERE parking_correspondant = ".$row['id'].";");
        
        while ($row2 = $result2->fetch_assoc()) {
            // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
            $row['points_de_recharge'][] = $row2['points_de_recharge'];
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

<!-- Voici un exemple de sortie :

[{"id":"1","nb_places":"10","securise":"1","abrite":"1","info_complementaires":"test","type_accroche":["V\u00e9lo classique","V\u00e9lo autre"]}]

on remaque que l'on a bien une liste de stations (ici il y a qu'une seule station dans la liste), 
et que chaque station a un dictionnaire avec toutes les infos statiques à propos de la station,
une des clés de ce dictionnaire est "type_accroche" qui contient une liste des types d'accroches de la station
-->