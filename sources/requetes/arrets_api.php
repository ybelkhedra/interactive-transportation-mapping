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

function sub_tab_is_in_tab($lignes, $nomCommercial, $destination, $vehicule) {
    foreach ($lignes as $ligne) {
        if ($ligne["nomCommercial"] == $nomCommercial && $ligne["destination"] == $destination && $ligne["vehicule"] == $vehicule) {
            return true;
        }
    }
    return false;
}

//On crée une requête pour sélectionner tous les arrêts
$arretsSQL = "SELECT DISTINCT arretsData.gid as id, arretsData.libelle, arretsData.vehicule, arretsData.latitude, arretsData.longitude FROM arretsData";

$arretsResult = $conn->query($arretsSQL);

$arretsData = array();
if ($arretsResult->num_rows > 0) {
    while ($arret = $arretsResult->fetch_assoc()) {
        //on ajoute a arretsData[] les informations de l'arret
        $lignes = array();
        //On recupere les lignes qui passent par cet arrêt"
        $requete = "SELECT DISTINCT nomCommercialData.libelle as nom, lignesData.libelle, lignesData.gid, lignesData.sens, lignesData.vehicule, lignesData.principale, lignesData.groupe, lignesData.rs_sv_ligne_a, lignesData.rg_sv_arret_p_nd, lignesData.rg_sv_arret_p_na, lignesData.mdate
        FROM lignesData
        INNER JOIN relationsLignesTronconsData ON relationsLignesTronconsData.rs_sv_chem_l = lignesData.gid
        INNER JOIN tronconsData ON tronconsData.gid = relationsLignesTronconsData.rs_sv_tronc_l
        INNER JOIN arretsData ON arretsData.gid = tronconsData.rg_sv_arret_p_nd
        INNER JOIN nomCommercialData ON nomCommercialData.gid = lignesData.rs_sv_ligne_a
        WHERE arretsData.gid = " . $arret["id"] . ";";
        $lignes_reponse = $conn->query($requete);
        if ($lignes_reponse->num_rows > 0) {
            while ($ligne = $lignes_reponse->fetch_assoc()) {

                $requete = "SELECT libelle FROM arretsData WHERE gid = " . $ligne["rg_sv_arret_p_na"] . ";";
                $destinatio_reponse = $conn->query($requete);
                if ($destinatio_reponse->num_rows > 0) {
                    $destination = $destinatio_reponse->fetch_assoc();
                }
                if (!sub_tab_is_in_tab($lignes, $ligne["nom"], $destination["libelle"], $ligne["vehicule"])) {
                    $lignes[] = array(
                        "nomCommercial" => $ligne["nom"],
                        "destination" => $destination["libelle"],
                        "vehicule" => $ligne["vehicule"],
                        "sens" => $ligne["sens"],
                        "liste_id_lignes" => array(),
                    );
                }
                //on ajoute l'id de la ligne dans le tableau des id de ligne
                $lignes[count($lignes) - 1]["liste_id_lignes"][] = $ligne["gid"];
            }
        }
        //on ajoute l'arret au tableau des arrets
        $arretsData[] = array(
            "id" => $arret["id"],
            "libelle" => $arret["libelle"],
            "vehicule" => $arret["vehicule"],
            "latitude" => $arret["latitude"],
            "longitude" => $arret["longitude"],
            "lignes" => $lignes
        );

        // si il y pas de ligne ne pas ajouter l'arret
        if (count($arretsData[count($arretsData) - 1]["lignes"]) == 0) {
            array_pop($arretsData);
        }
    }
}


//On encode les données en JSON et on les enregistre dans un fichier
$arretsJSON = json_encode($arretsData);
echo $arretsJSON;
//ecrire le resultat dans un fichier json pour le stocker
$fp = fopen('./sources/requetes/arrets.json', 'w');
fwrite($fp, $arretsJSON);
fclose($fp);

//On ferme la connexion à la base de données
$conn->close();
?>