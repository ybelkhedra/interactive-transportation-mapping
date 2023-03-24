<?php
// <!-- On fait la liste des types de puissances
    
//     -->
$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query("
SELECT * FROM puissances;
")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
        $puissances[] = $row;
    }
    // on libere la memoire
    $result->free();
}
else {
    echo "Erreur : " . $db->error;
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($puissances);

// on ferme la connexion à la base de données
$db->close();

// on termine notre script php
?>