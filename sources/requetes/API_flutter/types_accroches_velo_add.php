<?php

// on recupere les infos du formulaire
$nom = $_GET['nom'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO types_accroches_velo (nom) VALUES ('$nom')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    echo "Type d'accroche ajouté";
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>