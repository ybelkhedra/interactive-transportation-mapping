<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$nb_places = $_GET['nb_places'];
$type_accroche = json_decode($_GET['type_accroche']);
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];
$securise = $_GET['securise'];
$abrite = $_GET['abrite'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO stations_velo (nom, nb_places, securise, abrite, info_complementaires) VALUES ('$nom', '$nb_places', '$securise', '$abrite', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $id_stations_velo_ajouter = $db->insert_id;
    $sql = "INSERT INTO coordonnees_stations_velo (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql;
    if ($db->query($sql)) {
        $id_coordonnees_stations_velo_ajouter = $db->insert_id;
        $sql = "INSERT INTO situer_stations_velo (pt_velo, coordonnee) VALUES ('$id_stations_velo_ajouter', '$id_coordonnees_stations_velo_ajouter')";
        echo $sql;
        if($db->query($sql)) {
            for ($i = 0; $i < count($type_accroche); $i++) {
                $accroche = $type_accroche[$i];
                $sql = "INSERT INTO installer (station_velo, type_accroche) VALUES ('$id_stations_velo_ajouter', '$accroche')";
                echo $sql;
                if ($db->query($sql)) {
                    $success = 1;
                } else {
                    $success = 0;
                    echo "Erreur : " . $db->error;
                }
            }
        } else {
            $success = 0;
            echo "Erreur : " . $db->error;
        }
    } else {
        $success = 0;
        echo "Erreur : " . $db->error;
    }
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>