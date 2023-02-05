<?php
// <!-- 
// On fait la liste des lignes de cars, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS sous forme de liste de points qui lui sont associés
// - l'arret de depart 
// - celui de destination
// - pas besoin de la liste des arrets !
// -->
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT lignes_cars.*, latitude, longitude
FROM lignes_cars
INNER JOIN situer_lignes_cars
    ON lignes_cars.id = situer_lignes_cars.ligne_car
INNER JOIN coordonnees_lignes_cars
    ON situer_lignes_cars.coordonnee = coordonnees_lignes_cars.id
;
")) {
    while ($row = $result->fetch_assoc()) {
        // une particularité de cet exemple : chaque station de velo peut avoir plusieur types d'accroches
        // cette exemple peut donc servir de base pour les autres requetes qui ont des relations 1-n ou n-n (plusieurs types d'accroches, plusieurs types de vehicules autorisés, plusieurs points gps (cf lignes), etc.)
        
        // on ajoute une colone "type_accroche" à notre tableau $row afin de stocker les types d'accroches de la station correspondant à la ligne courante
        $row = array_merge($row, array("arret_cars_depart" => array()));
        $row = array_merge($row, array("arret_cars_destination" => array()));
        // on recupere les types d'accroches de la station courante
        $result2 = $db->query("SELECT arrets_cars.nom as arret_cars_depart FROM arrets_cars INNER JOIN lignes_cars ON arrets_cars.id = lignes_cars.depart WHERE arrets_cars.id = ".$row['depart'].";");
        $result3 = $db->query("SELECT arrets_cars.nom as arret_cars_destination FROM arrets_cars INNER JOIN lignes_cars ON arrets_cars.id = lignes_cars.destination WHERE arrets_cars.id = ".$row['destination'].";");

        $row2 = $result2->fetch_assoc();
        $row3 = $result3->fetch_assoc();

        $row['arret_cars_depart'][] = $row2['arret_cars_depart'];
        $row['arret_cars_destination'][] = $row3['arret_cars_destination'];

        // on libere la memoire
        $result2->free();
        $result3->free();
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
