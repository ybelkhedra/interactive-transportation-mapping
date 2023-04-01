<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

$gid = $_GET['gid'];

$arret = "inconnu";

if ($result = $db->query("SELECT ident FROM ident WHERE gid = ".$gid.";")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
        $arret = $row["ident"];
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($arret);

// on ferme la connexion à la base de données
$db->close();

// on termine notre script php
?>
