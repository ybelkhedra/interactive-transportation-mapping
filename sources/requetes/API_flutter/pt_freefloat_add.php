<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$vehicules_freefloating = json_decode($_GET['vehicules_freefloating']);
$info_complementaires = $_GET['info_complementaires'];
$coordonnees = json_decode($_GET['coordonnees']);

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO pt_freefloat (nom, info_complementaires) VALUES ('$nom', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $id_pt_freefloat_ajouter = $db->insert_id;
    for($i = 0; $i < count(coordonnees); $i++)
    {
        $latitude = $coordonnees[$i]['latitude'];
        $longitude = $coordonnees[$i]['longitude'];
        $sql = "INSERT INTO coordonnees_pt_freefloat (latitude, longitude) VALUES ('$latitude', '$longitude')";
        echo $sql;
        if ($db->query($sql)) {
            $id_coordonnees_pt_freefloat_ajouter = $db->insert_id;
            $sql = "INSERT INTO situer_pt_freefloat (pt_freefloat, coordonnee) VALUES ('$id_pt_freefloat_ajouter', '$id_coordonnees_pt_freefloat_ajouter')";
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
    for ($i = 0; $i < count($vehicules_freefloating); $i++) {
        $vehicule = $vehicules_freefloating[$i];
        $sql = "INSERT INTO autoriser (pt_freefloat, vehicule) VALUES ('$id_pt_freefloat_ajouter', '$vehicule')";
        echo $sql;
        if ($db->query($sql)) {
            $success = 1;
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