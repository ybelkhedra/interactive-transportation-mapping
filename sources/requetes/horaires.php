<?php

$servername = "localhost";
$username = "root";
$password = "@Password0";
$dbname = "campus";

// Créer une connexion à la base de données
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Erreur de connexion : " . $conn->connect_error);
}


//recuperation des parametres get
$arret_gid = $_GET['arret_gid'];
$lignes_id = $_GET['ligne_id'];



//on recupere les horaires de chaque ligne
$horaires = array();
$requete = "
SELECT horairesData.hor_theo, horairesData.hor_app, horairesData.hor_real, arretsData.libelle, lignesData.gid FROM 
horairesData INNER JOIN CoursesData ON horairesData.rs_sv_cours_a = CoursesData.gid
INNER JOIN lignesData ON CoursesData.rs_sv_chem_l = lignesData.gid
INNER JOIN arretsData ON horairesData.rs_sv_arret_p = arretsData.gid
WHERE arretsData.gid = '".$arret_gid."' AND lignesData.gid = '".$lignes_id."'
ORDER BY horairesData.hor_theo ASC
LIMIT 10;
";
// echo $requete;
$horaires_reponse = $conn->query($requete);

if ($horaires_reponse->num_rows > 0) {
    while ($horaire = $horaires_reponse->fetch_assoc()) {
        $horaires[] = array(
            "horaire_theorique" => $horaire["hor_theo"],
            "horaire_apparent" => $horaire["hor_app"],
            "horaire_reel" => $horaire["hor_real"],
            "arret" => $horaire["libelle"],
            "ligne_id" => $horaire["gid"],
        );
    }
}

$horaires_reponse->close();

echo json_encode($horaires);




?>