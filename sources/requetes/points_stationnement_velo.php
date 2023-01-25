<!-- FICHIER DE REQUETE POUR LES POINTS DE STATIONNEMENT VÉLO -->

<!-- on commence notre script php -->
<?php
// on se connecte à la base de données (ne pas changer les paramètres, 
//car c'est ceux utilisés par le serveur), tant pis si vous ne pouvez 
//pas executer ce script sur votre machine locale ou alors changez les paramètres de votre bdd mysql
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT stations_velo.id, nb_places, securise, abrite, info_complementaires FROM stations_velo INNER JOIN 
situer_stations_velo ON stations_velo.id = situer_stations_velo.pt_velo INNER JOIN
coordonnees_stations_velo ON situer_stations_velo.coordonnee = coordonnees_stations_velo.id
;
")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
        // une particularité de cet exemple : chaque station de velo peut avoir plusieur types d'accroches
        // cette exemple peut donc servir de base pour les autres requetes qui ont des relations 1-n ou n-n (plusieurs types d'accroches, plusieurs types de vehicules autorisés, plusieurs points gps (cf lignes), etc.)
        
        // on ajoute une colone "type_accroche" à notre tableau $row afin de stocker les types d'accroches de la station correspondant à la ligne courante
        $row = array_merge($row, array("type_accroche" => array()));
        // on recupere les types d'accroches de la station courante
        $result2 = $db->query("SELECT types_accroches_velo.nom as type_accroche FROM installer INNER JOIN types_accroches_velo ON installer.type_accroche = types_accroches_velo.id WHERE station_velo = ".$row['id'].";");
        
        // on parcourt les types d'accroches de la station courante
        while ($row2 = $result2->fetch_assoc()) {
            // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
            $row['type_accroche'][] = $row2['type_accroche'];
        }
        // on libere la memoire
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