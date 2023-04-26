<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];
$vehicules_autorises = $_GET['vehiculesAutorise'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO pt_freefloat (nom, info_complementaires) VALUES ('$nom','$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $sql2 = "INSERT INTO coordonnees_pt_freefloat (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql2;
    $id_freefloating_ajouter = $db->insert_id;

    if ($db->query($sql2)) {

        $id_coordonnees_freefloating_ajouter = $db->insert_id;
        
        // ajouter les données dans la table situer_parkings (id_parking, id_coordonnees_parking)
        $sql3 = "INSERT INTO situer_pt_freefloat (pt_freefloat, coordonnee) VALUES ('$id_freefloating_ajouter', '$id_coordonnees_freefloating_ajouter')";
        echo $sql3;
        if ($db->query($sql3)) {
            echo "Freefloating ajouté";
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