<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if(isset($_GET['date'])) {
    $date = $_GET['date'];

    // Requête SQL pour sélectionner les informations des capteurs et le nombre total de véhicules par classe pour la date donnée
    $sql = "SELECT
                c.*,
                COUNT(d.classe_vehicule) AS total_vehicules,
                COUNT(CASE WHEN cv.classe = 'EDPM/Trottinette' THEN d.classe_vehicule END) AS total_vehicules_EDPM_Trottinette,
                COUNT(CASE WHEN cv.classe = 'VELO' THEN d.classe_vehicule END) AS total_vehicules_VELO,
                COUNT(CASE WHEN cv.classe = 'MOTO' THEN d.classe_vehicule END) AS total_vehicules_MOTO,
                COUNT(CASE WHEN cv.classe = 'Deux roues/2RM/2R' THEN d.classe_vehicule END) AS total_vehicules_Deux_roues_2RM_2R,
                COUNT(CASE WHEN cv.classe = 'VL' THEN d.classe_vehicule END) AS total_vehicules_VL,
                COUNT(CASE WHEN cv.classe = 'BUS' THEN d.classe_vehicule END) AS total_vehicules_BUS,
                COUNT(CASE WHEN cv.classe = 'PL' THEN d.classe_vehicule END) AS total_vehicules_PL,
                COUNT(CASE WHEN cv.classe = 'PL_1' THEN d.classe_vehicule END) AS total_vehicules_PL_1,
                COUNT(CASE WHEN cv.classe = 'PL_2' THEN d.classe_vehicule END) AS total_vehicules_PL_2,
                COUNT(CASE WHEN cv.classe = 'PL/BUS' THEN d.classe_vehicule END) AS total_vehicules_PL_BUS,
                COUNT(CASE WHEN cv.classe = 'UT' THEN d.classe_vehicule END) AS total_vehicules_UT,
                COUNT(CASE WHEN cv.classe = 'PT' THEN d.classe_vehicule END) AS total_vehicules_PT
            FROM capteurs c
            LEFT JOIN donnees_capteurs d ON c.id = d.capteur
            LEFT JOIN classes_vehicules cv ON d.classe_vehicule = cv.id
            WHERE DATE(d.horodate) = '$date'
            GROUP BY c.id, c.nom, c.type_capteur";

    // Exécution de la requête
    $result = $db->query($sql);

    // Vérifier s'il y a des résultats
    if ($result && $result->num_rows > 0) {
        $capteurs = array();
        while ($row = $result->fetch_assoc()) {
            $capteurs[] = $row;
        }
    } else {
        echo "Aucun résultat trouvé pour la date donnée.";
    }

    // Libérer la mémoire du résultat
    $result->free();
} else {
    echo "La date n'est pas spécifiée dans l'URL.";
}

// on encode la liste des stations au format json, et on l'affiche
echo json_encode($capteurs);

$db->close();
?>