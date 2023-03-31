<?php

$numero = $_GET['numero'];
$depart = $_GET['depart'];
$arret_cars_depart = json_decode($_GET['arret_cars_depart']);
$destination = $_GET['destination'];
$arret_cars_destination = json_decode($_GET['arret_cars_destination']);
$car_express = $_GET['car_express'];
$info_complementaires = $_GET['info_complementaires'];
$coordonnees = json_decode($_GET['coordonnees'], true); // format : liste de dictionnaire aux clés latitude et longitude"

$db = new mysqli("localhost", "root", "@Password0", "campus");

$sql = "INSERT INTO lignes_cars (numero, depart, destination, car_express, info_complementaires) VALUES ('$numero', '$depart', '$destination', '$car_express', '$info_complementaires')";
echo $sql;
if ($db->query($sql)) {
    $id_lignes_cars_ajouter = $db->insert_id;
    for ($i = 0; $i < count($coordonnees); $i++) {
        $latitude = $coordonnees[$i]['latitude'];
        $longitude = $coordonnees[$i]['longitude'];
        $sql = "INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES ('$latitude', '$longitude')";
        echo $sql;
        if ($db->query($sql)) {
            $id_coordonnees_lignes_cars_ajouter = $db->insert_id;
            $sql = "INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES ('$id_lignes_cars_ajouter', '$id_coordonnees_lignes_cars_ajouter')";
            echo $sql;
            if($db->query($sql)) {
                $success = 1;
            } else {
                $success = 0;
                echo "Erreur : " . $db->error;
            }
        } else {
            $success = 0;
            echo "Erreur : " . $db->error;
        }
    }
    for ($i = 0; $i < count($arret_cars_depart); $i++) {
        $arret_depart = $arret_cars_depart[$i];
        $sql = "INSERT INTO desservir_car (arret_car, ligne_car) VALUES ('$arret_depart', '$id_lignes_cars_ajouter')";
        if ($db->query($sql))
        {
            $success = 1;
        }
        else {
            $success = 0;
            echo "Erreur : " . $db->error;
        }
    }
    for ($i = 0; $i < count($arret_cars_destination); $i++) {
        $arret_destination = $arret_cars_destination[$i];
        $sql = "INSERT INTO desservir_car (arret_car, ligne_car) VALUES ('$arret_destination', '$id_lignes_cars_ajouter')";
        if ($db->query($sql))
        {
            $success = 1;
        }
        else {
            $success = 0;
            echo "Erreur : " . $db->error;
        }
    }
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>