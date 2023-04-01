<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$ligne_car = json_decode($_GET['ligne_car']);
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];


$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO arrets_cars (nom, info_complementaires) VALUES ('$nom', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $id_arrets_cars_ajouter = $db->insert_id;
    $sql = "INSERT INTO coordonnees_arrets_cars (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql;
    if ($db->query($sql)) {
        $id_coordonnees_arrets_cars_ajouter = $db->insert_id;
        $sql = "INSERT INTO situer_arrets_cars (arret_car, coordonnee) VALUES ('$id_arrets_cars_ajouter', '$id_coordonnees_arrets_cars_ajouter')";
        echo $sql;
        if($db->query($sql)) {
            for ($i = 0; $i < count($ligne_car); $i++) {
                $ligne = $ligne_car[$i];
                $sql = "INSERT INTO desservir_car (arret_car, ligne_car) VALUES ('$id_arrets_cars_ajouter', '$ligne')";
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