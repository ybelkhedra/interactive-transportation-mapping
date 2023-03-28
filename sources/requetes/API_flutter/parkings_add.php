<?php

// on recupere le gid du parking à supprimer par get
$nom = $_GET['nom'];
$nbPlacesMax = $_GET['nbPlacesMax'];
$boolPayant = $_GET['boolPayant'];
$nbPlacesHandicapes = $_GET['nbPlacesHandicapes'];
$boolHorsVoirie = $_GET['boolHorsVoirie'];
$boolPrive = $_GET['boolPrive'];
$infoComplementaires = $_GET['infoComplementaires'];
$latitude = $_GET['latitude'];
$longitude = $_GET['longitude'];
$nb_places_disponibles = $_GET['nbPlacesDisponibles'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO parkings (nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES ('$nom', '$nbPlacesMax', '$nb_places_disponibles', '$boolPayant', '$nbPlacesHandicapes', '$boolHorsVoirie', '$boolPrive', '$infoComplementaires')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    $sql2 = "INSERT INTO coordonnees_parkings (latitude, longitude) VALUES ('$latitude', '$longitude')";
    echo $sql2;
    $id_parking_ajouter = $db->insert_id;

    if ($db->query($sql2)) {

        $id_coordonnees_parking_ajouter = $db->insert_id;
        
        // ajouter les données dans la table situer_parkings (id_parking, id_coordonnees_parking)
        $sql3 = "INSERT INTO situer_parkings (parking, coordonnee) VALUES ('$id_parking_ajouter', '$id_coordonnees_parking_ajouter')";
        echo $sql3;
        if ($db->query($sql3)) {
            echo "Parking ajouté";
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