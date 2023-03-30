<?php

$type_piste = $_GET['type_piste'];
$info_complementaires = $_GET['info_complementaires'];
$coordonnees = json_decode($_GET['coordonnees'], true); // format : liste de dictionnaire aux clés latitude et longitude"

$db = new mysqli("localhost", "root", "@Password0", "campus");

$sql = "INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES ('$type_piste', '$info_complementaires')";
echo $sql;
if ($db->query($sql)) {
    $id_pistes_velo_ajouter = $db->insert_id;
    for ($i = 0; $i < count($coordonnees); $i++) {
        $latitude = $coordonnees[$i]['latitude'];
        $longitude = $coordonnees[$i]['longitude'];
        $sql = "INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES ('$latitude', '$longitude')";
        echo $sql;
        if ($db->query($sql)) {
            $id_coordonnees_pistes_velo_ajouter = $db->insert_id;
            $sql = "INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES ('$id_pistes_velo_ajouter', '$id_coordonnees_pistes_velo_ajouter')";
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