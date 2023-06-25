<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

$csvFile = "../../donnees/csv/P1_test.csv";

if (($handle = fopen($csvFile, "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 100, ",")) !== FALSE) {
        $horodate = $data[2];
        $capteur = 1;

        $sql = "INSERT INTO donnees_capteurs (horodate, capteur) VALUES ('$horodate', '$capteur')";

        // Exécution de la requête
        if ($db->query($sql) !== TRUE) {
            echo "Erreur lors de l'insertion des données : " . $db->error;
        }
    }
    fclose($handle);
} else {
    echo "Erreur lors de l'ouverture du fichier CSV.";
}

// On execute notre requete SQL
if ($result = $db->query("
SELECT *
FROM donnees_capteurs
;
")) {
    $donnees_capteurs = array();
    while ($row = $result->fetch_assoc()) {
        $donnees_capteurs[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($donnees_capteurs);

$db->close();
?>