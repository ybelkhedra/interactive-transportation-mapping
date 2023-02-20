<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

$gid = $_GET['gid'];

$resultat = array();

if ($result = $db->query("SELECT DISTINCT relationsLignesTronconsData.rs_sv_chem_l FROM relationsLignesTronconsData WHERE relationsLignesTronconsData.rs_sv_tronc_l = ".$gid.";")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
        // $tmp = {"ligne_nb" : $row["rs_sv_chem_l"], "ligne" : ""};
        $ligne_nb = $row["rs_sv_chem_l"];
        if ($result2 = $db->query("SELECT DISTINCT lignesData.libelle FROM lignesData WHERE lignesData.gid = ".$ligne_nb.";")) {
            while ($row2 = $result2->fetch_assoc()) {
                $ligne = $row2["libelle"];
            }
            $result2->free();
        }
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($ligne_nb, $ligne);

// on ferme la connexion à la base de données
$db->close();

// on termine notre script php
?>
