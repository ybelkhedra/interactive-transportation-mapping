<?php
// on recupere le nom et l'id à supprimer par get
$nom = $_GET['nom'];
$gid = $_GET['id'];
$db = new mysqli("localhost", "root", "@Password0", "campus");

// on supprime l'élement d'id id dans la table $nom
echo "DELETE FROM ".$nom." WHERE id = ".$gid.";";
if ($db->query("DELETE FROM ".$nom." WHERE id = ".$gid.";")) {
    $success = 1;

}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}

//renvoie success = 1 si la requete a reussi, 0 sinon
echo json_encode(array("success" => $success));
?>