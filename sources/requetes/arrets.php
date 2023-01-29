<!-- FICHIER DE REQUETE POUR LES ARRETS -->


<!-- 
    On fait la liste des arrets, avec pour chacun toutes ses informations statiques mais aussi : 
- la position GPS pas besoin d'en faire une liste car cela sera un point unique
- la station vcube a proximite
- la liste des lignes qui lui sont associées
- heure de premier passage de chaque ligne qui lui sont associées
- heure de dernier passage de chaque ligne qui lui sont associées
- frequence de chaque ligne qui lui sont associées
- diurne/nocturne de chaque ligne qui lui sont associées
-->


<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT arrets.*, latitude, longitude
FROM arrets
INNER JOIN situer_arrets
    ON arrets.id = situer_arrets.arret
INNER JOIN coordonnees_arrets
    ON situer_arrets.coordonnee = coordonnees_arrets.id
;
")) {
    while ($row = $result->fetch_assoc()) {
        // une particularité de cet exemple : chaque station de velo peut avoir plusieur types d'accroches
        // cette exemple peut donc servir de base pour les autres requetes qui ont des relations 1-n ou n-n (plusieurs types d'accroches, plusieurs types de vehicules autorisés, plusieurs points gps (cf lignes), etc.)
        
        // on ajoute une colone "type_accroche" à notre tableau $row afin de stocker les types d'accroches de la station correspondant à la ligne courante
        $row = array_merge($row, array("ligne" => array()));
        // on recupere les types d'accroches de la station courante
        $result2 = $db->query("SELECT lignes.nom as ligne, heure_premier_passage, heure_dernier_passage, frequence, diurne, nocturne FROM desservir INNER JOIN lignes ON desservir.ligne = lignes.id WHERE arret = ".$row['id'].";");
        
        // on parcourt les types d'accroches de la station courante
        while ($row2 = $result2->fetch_assoc()) {
            // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
            $row['ligne'][] = $row2['ligne'];
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

$db->close();

?>
