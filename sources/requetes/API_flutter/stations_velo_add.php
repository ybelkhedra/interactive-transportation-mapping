<?php

// on recupere les infos du formulaire
$nom = $_GET['nom'];
$nb_places = $_GET['nb_places'];
$securise = $_GET['securise'];
$abrite = $_GET['abrite'];
$type_accroche = $_GET['type_accroche'];
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

$sql = "INSERT INTO stations_velo (nom, nb_places, securise, abrite, info_complementaires) VALUES ('$nom', '$nb_places', '$securise', '$abrite', $info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $sql2 = "INSERT INTO coordonnees_stations_velo (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql2;
    $id_stations_velo_ajouter = $db->insert_id;

    if ($db->query($sql2)) {

        $id_coordonnees_stations_velo_ajouter = $db->insert_id;
        
        // ajouter les données dans la table situer_parkings (id_parking, id_coordonnees_parking)
        $sql3 = "INSERT INTO situer_stations_velo (pt_velo, coordonnee) VALUES ('$id_stations_velo_ajouter', '$id_coordonnees_stations_velo_ajouter')";
        echo $sql3;
        if ($db->query($sql3)) {
            $sql4 = "INSERT INTO installer (station_velo, type_accroche) VALUES ('$id_stations_velo_ajouter', '$type_accroche')";
            echo $sql4;
            if ($db->query($sql4)) {
                echo "Station de vélo ajouté";
            }
            else {
                $success = 0;
                echo "Erreur : " . $db->error;
            }
        }
        else {
            $success = 0;
            echo "Erreur : " . $db->error;
        }

    }
    else {
        $success = 0;
        echo "Erreur : " . $db->error;
    }

}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>