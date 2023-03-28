<?php

// on recupere les infos du formulaire
$nom = $_GET['nom'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO types_de_prises (nom) VALUES ('$nom')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    echo "Type de prise ajouté";
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>