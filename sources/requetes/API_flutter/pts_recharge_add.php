<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$parking_correspondant = $_GET['parking_correspondant'];
$type_prise = json_decode($_GET['type_prise']);
$puissance = json_decode($_GET['puissance']);
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO pts_recharge (nom, parking_correspondant, info_complementaires) VALUES ('$nom', '$parking_correspondant', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $id_pt_recharge_ajouter = $db->insert_id;
    $sql = "INSERT INTO coordonnees_pts_recharge (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql;
    if ($db->query($sql)) {
        $id_coordonnees_pt_recharge_ajouter = $db->insert_id;
        $sql = "INSERT INTO situer_pts_recharge (point_de_recharge, coordonnee) VALUES ('$id_pt_recharge_ajouter', '$id_coordonnees_pt_recharge_ajouter')";
        echo $sql;
        if($db->query($sql)) {
            for ($i = 0; $i < count($type_prise); $i++) {
                $prise = $type_prise[$i];
                $sql = "INSERT INTO compatible (point_de_recharge, type_de_prise) VALUES ('$id_pt_recharge_ajouter', '$prise')";
                echo $sql;
                if ($db->query($sql)) {
                    $success = 1;
                } else {
                    $success = 0;
                    echo "Erreur : " . $db->error;
                }
            }
            for ($i = 0; count($puissance); $i++)
            {
                $puiss = $puissance[$i];
                $sql = "INSERT INTO recharger (puissance, point_de_recharge) VALUES ('$puiss', '$id_pt_recharge_ajouter')";
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