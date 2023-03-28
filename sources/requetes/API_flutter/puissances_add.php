<?php

// on recupere les infos du formulaire
$puissance = $_GET['puissance'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

//ajouter les données dans la table parking
$sql = "INSERT INTO puissances (puissance) VALUES ('$puissance')";
echo $sql;
//exécution de la requête
if ($db->query($sql)) {
    echo "Puissances ajouté";
}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}
?>