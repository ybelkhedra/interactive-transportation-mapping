<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$nb_places_max = $_GET['nb_places_max'];
$payant = $_GET['payant'];
$nb_places_handicapes = $_GET['nb_places_handicapes'];
$hors_voirie = $_GET['hors_voirie'];
$prive = $_GET['prive'];
$informations_complementaires = $_GET['informations_complementaires'];
$coordonnees = json_decode($_GET['coordonnees'], true); // format : liste de dictionnaire aux clés latitude et longitude"

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO parkings (nom, nb_places_max, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES ('$nom', '$nb_places_max', '$payant', '$nb_places_handicapes', '$hors_voirie', '$prive', '$informations_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $id_parking_ajouter = $db->insert_id;
    for ($i = 0; $i < count($coordonnees); $i++) {
        $latitude = $coordonnees[$i]['latitude'];
        $longitude = $coordonnees[$i]['longitude'];
        $sql = "INSERT INTO coordonnees_parkings (latitude, longitude) VALUES ('$latitude', '$longitude')";
        echo $sql;
        if ($db->query($sql)) {
            $id_coordonnees_parking_ajouter = $db->insert_id;
            $sql = "INSERT INTO situer_parkings (parking, coordonnee) VALUES ('$id_parking_ajouter', '$id_coordonnees_parking_ajouter')";
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
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>