<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$nb_velos_max = $_GET['nb_velos_max'];
$arrets_proximite = json_decode($_GET['arrets_proximite']);
$nb_velos_dispo = $_GET['nb_velos_dispo'];
$velos_electriques = $_GET['velos_electriques'];
$vcube_plus = $_GET['vcube_plus'];
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];


$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO stations_vcube (nom, nb_velos_max, nb_velos_dispo, velos_electriques, vcube_plus, info_complementaires) VALUES ('$nom', '$nb_velos_max', '$nb_velos_dispo', '$velos_electriques', '$vcube_plus', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $id_stations_vcube_ajouter = $db->insert_id;
    $sql = "INSERT INTO coordonnees_stations_vcube (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql;
    if ($db->query($sql)) {
        $id_coordonnees_stations_vcube_ajouter = $db->insert_id;
        $sql = "INSERT INTO situer_stations_vcube (station_vcube, coordonnee) VALUES ('$id_stations_vcube_ajouter', '$id_coordonnees_stations_vcube_ajouter')";
        echo $sql;
        if($db->query($sql)) {
            for ($i = 0; $i < count($arrets_proximite); $i++) {
                $arret = $arrets_proximite[$i];
                $sql = "INSERT INTO arrets (station_vcube_proximite, vehicule) VALUES ('$id_stations_vcube_ajouter', '$arret')";
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