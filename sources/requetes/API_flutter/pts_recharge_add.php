<?php

// on recupere les infos du formulaire
$nom = $_GET['nom'];
$parking_correspondant = $_GET['parking_correspondant'];
$type_prise = $_GET['type_prise'];
$puissance = $_GET['puissance'];
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO pts_recharge (nom, info_complementaires) VALUES ('$nom', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $sql2 = "INSERT INTO coordonnees_pts_recharge (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql2;
    $id_pt_recharge_ajouter = $db->insert_id;

    if ($db->query($sql2)) {

        $id_coordonnees_pt_recharge_ajouter = $db->insert_id;
        
        // ajouter les données dans la table situer_parkings (id_parking, id_coordonnees_parking)
        $sql3 = "INSERT INTO situer_pts_recharge (point_de_recharge, coordonnee) VALUES ('$id_pt_recharge_ajouter', '$id_coordonnees_pt_recharge_ajouter')";
        echo $sql3;
        if ($db->query($sql3)) {
            $sql4 = "INSERT INTO compatible (type_de_prise, point_de_recharge) VALUES ('$type_prise', '$id_pt_recharge_ajouter')";
            echo $sql4;
            if ($db->query($sql4)) {
                $sql5 = "INSERT INTO recharger (puissance, point_de_recharge) VALUES ('$puissance', '$id_pt_recharge_ajouter')";
                echo $sql5;
                if ($db->query($sql5)) {
                    echo "Point de recharge ajouté";
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

}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>