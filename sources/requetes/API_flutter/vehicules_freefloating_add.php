<?php

// on recupere les infos du formulaire
$vehicule = $_GET['vehicule'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO vehicules_freefloating (vehicule) VALUES ('$vehicule')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    echo "Véhicule ajouté";
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>