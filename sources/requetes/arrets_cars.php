<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// // On execute notre requete SQL
// if ($result = $db->query("
// SELECT arrets_cars.*, latitude, longitude
// FROM arrets_cars 
// INNER JOIN situer_arrets_cars 
//     ON arrets_cars.id = situer_arrets_cars.arret_car
// INNER JOIN coordonnees_arrets_cars 
//     ON situer_arrets_cars.coordonnee = coordonnees_arrets_cars.id
// ;
// ")) {
//     while ($row = $result->fetch_assoc()) {
//         // une particularité de cet exemple : chaque station de velo peut avoir plusieur types d'accroches
//         // cette exemple peut donc servir de base pour les autres requetes qui ont des relations 1-n ou n-n (plusieurs types d'accroches, plusieurs types de vehicules autorisés, plusieurs points gps (cf lignes), etc.)
        
//         // on ajoute une colone "ligne_car" à notre tableau $row afin de stocker les types d'accroches de la station correspondant à la ligne courante
//         $row = array_merge($row, array("ligne_car" => array()));
//         // on recupere les types d'accroches de la station courante
//         $result2 = $db->query("SELECT lignes_cars.numero FROM desservir_car INNER JOIN lignes_cars ON desservir_car.ligne_car = lignes_cars.id WHERE arret_car = ".$row['id'].";");
        
//         // on parcourt les types d'accroches de la station courante
//         // while ($row2 = $result2->fetch_assoc()) {
//         //     // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
//         //     $row['ligne_car'][] = $row2['numero'];
//         // }
//         // on libere la memoire
//         $result2->free();
//         // on ajoute la station courante à la liste des stations
//         $parkings[] = $row;
//     }
//     // on libere la memoire
//     $result->free();
// }
// // on encode la liste des stations au format json, et on l'affiche
// echo json_encode($parkings);

if ($result = $db->query(" SELECT stop_id, stop_lat, stop_lon, stop_name FROM stop;")) {
    while ($row = $result->fetch_assoc()) {
        $row = array_merge($row, array("ligne_car" => array()));
        // echo "SELECT route_short_name, route_long_name FROM routes WHERE route_id IN (SELECT route_id FROM trips WHERE trip_id IN (SELECT trip_id FROM stop_times WHERE stop_id = ".$row['stop_id']."));\n\n";
        if ($result2 = $db->query("SELECT route_short_name, route_long_name FROM routes WHERE route_id IN (SELECT route_id FROM trips WHERE trip_id IN (SELECT trip_id FROM stop_times WHERE stop_id = ".$row['stop_id']."));"))
        {
            while ($row2 = $result2->fetch_assoc()) {
                $row['ligne_car'][] = [$row2['route_short_name'], $row2['route_long_name']];
            }
            $result2->free();
        }
        $res[] = $row;
    }
    $result->free();
}
echo json_encode($res);
$db->close();

?>
