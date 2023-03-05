<?php
// on recupere le gid du parking à supprimer par get
$gid = $_GET['id'];
$db = new mysqli("localhost", "root", "@Password0", "campus");

// on supprime le parking
echo "DELETE FROM pt_freefloat WHERE id = ".$gid.";";
if ($db->query("DELETE FROM pt_freefloat WHERE id = ".$gid.";")) {
    $success = 1;

}
else {
    $success = 0;
    echo "Erreur : " . $db->error;
}

//renvoie success = 1 si la requete a reussi, 0 sinon
echo json_encode(array("success" => $success));
?>