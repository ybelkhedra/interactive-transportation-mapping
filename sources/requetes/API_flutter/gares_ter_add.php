<?php

// on recupere les infos du formulaire
$nom = $_GET['nom'];
$info_complementaires = $_GET['info_complementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

$sql = "INSERT INTO gares_ter (nom, info_complementaires) VALUES ('$nom', '$info_complementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $sql2 = "INSERT INTO coordonnees_gares_ter (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql2;
    $id_gares_ter_ajouter = $db->insert_id;

    if ($db->query($sql2)) {

        $id_coordonnees_gares_ter_ajouter = $db->insert_id;
        
        // ajouter les données dans la table situer_parkings (id_parking, id_coordonnees_parking)
        $sql3 = "INSERT INTO situer_gares_ter (gare_ter, coordonnee) VALUES ('$id_gares_ter_ajouter', '$id_coordonnees_gares_ter_ajouter')";
        echo $sql3;
        if ($db->query($sql3)) {
            echo "Gare TER ajouté";
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