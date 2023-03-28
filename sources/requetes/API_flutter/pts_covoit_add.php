<?php

// on recupere les infos du formulaire
$nom = $_GET['nom'];
$nombre_de_places = $_GET['nombre_de_places'];
$parking_correspondant = $_GET['parking_correspondant'];
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

$sql = "INSERT INTO pts_covoit (nom, info_complementaires, nombre_de_places, parking_correspondant) VALUES ('$nom', '$info_complementaires', $nombre_de_places, '$parking_correspondant')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $sql2 = "INSERT INTO coordonnees_pts_covoit (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql2;
    $id_pt_covoit_ajouter = $db->insert_id;

    if ($db->query($sql2)) {

        $id_coordonnees_pt_covoit_ajouter = $db->insert_id;
        
        // ajouter les données dans la table situer_parkings (id_parking, id_coordonnees_parking)
        $sql3 = "INSERT INTO situer_pts_covoit (point_de_covoiturage, coordonnee) VALUES ('$id_pt_covoit_ajouter', '$id_coordonnees_pt_covoit_ajouter')";
        echo $sql3;
        if ($db->query($sql3)) {
            echo "Point de covoiturage ajouté";
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