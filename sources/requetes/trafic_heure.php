<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if(isset($_GET['date']) && isset($_GET['heure1']) && isset($_GET['heure2'])) {
    $date = $_GET['date'];
    $heure1 = $_GET['heure1'];
    $heure2 = $_GET['heure2'];

    // Requête SQL pour sélectionner les informations des capteurs et le nombre total de véhicules par classe pour la date donnée
    $sql = "SELECT
                c.*,
                IFNULL(total_vehicules, 0) AS total_vehicules,
                IFNULL(total_vehicules_EDPM_Trottinette, 0) AS total_vehicules_EDPM_Trottinette,
                IFNULL(total_vehicules_VELO, 0) AS total_vehicules_VELO,
                IFNULL(total_vehicules_MOTO, 0) AS total_vehicules_MOTO,
                IFNULL(total_vehicules_Deux_roues_2RM_2R, 0) AS total_vehicules_Deux_roues_2RM_2R,
                IFNULL(total_vehicules_VL, 0) AS total_vehicules_VL,
                IFNULL(total_vehicules_BUS, 0) AS total_vehicules_BUS,
                IFNULL(total_vehicules_PL, 0) AS total_vehicules_PL,
                IFNULL(total_vehicules_PL_1, 0) AS total_vehicules_PL_1,
                IFNULL(total_vehicules_PL_2, 0) AS total_vehicules_PL_2,
                IFNULL(total_vehicules_PL_BUS, 0) AS total_vehicules_PL_BUS,
                IFNULL(total_vehicules_UT, 0) AS total_vehicules_UT,
                IFNULL(total_vehicules_PT, 0) AS total_vehicules_PT
            FROM capteurs c
            LEFT JOIN (
                SELECT
                    capteur,
                    COUNT(classe_vehicule) AS total_vehicules,
                    COUNT(CASE WHEN cv.classe = 'EDPM/Trottinette' THEN classe_vehicule END) AS total_vehicules_EDPM_Trottinette,
                    COUNT(CASE WHEN cv.classe = 'VELO' THEN classe_vehicule END) AS total_vehicules_VELO,
                    COUNT(CASE WHEN cv.classe = 'MOTO' THEN classe_vehicule END) AS total_vehicules_MOTO,
                    COUNT(CASE WHEN cv.classe = 'Deux roues/2RM/2R' THEN classe_vehicule END) AS total_vehicules_Deux_roues_2RM_2R,
                    COUNT(CASE WHEN cv.classe = 'VL' THEN classe_vehicule END) AS total_vehicules_VL,
                    COUNT(CASE WHEN cv.classe = 'BUS' THEN classe_vehicule END) AS total_vehicules_BUS,
                    COUNT(CASE WHEN cv.classe = 'PL' THEN classe_vehicule END) AS total_vehicules_PL,
                    COUNT(CASE WHEN cv.classe = 'PL_1' THEN classe_vehicule END) AS total_vehicules_PL_1,
                    COUNT(CASE WHEN cv.classe = 'PL_2' THEN classe_vehicule END) AS total_vehicules_PL_2,
                    COUNT(CASE WHEN cv.classe = 'PL/BUS' THEN classe_vehicule END) AS total_vehicules_PL_BUS,
                    COUNT(CASE WHEN cv.classe = 'UT' THEN classe_vehicule END) AS total_vehicules_UT,
                    COUNT(CASE WHEN cv.classe = 'PT' THEN classe_vehicule END) AS total_vehicules_PT
                FROM donnees_capteurs d
                LEFT JOIN classes_vehicules cv ON d.classe_vehicule = cv.id
                WHERE DATE(d.horodate) = '$date'
                    AND TIME(d.horodate) >= '$heure1'
                    AND TIME(d.horodate) < '$heure2'
                GROUP BY capteur
            ) AS dc ON c.id = dc.capteur;
            ";

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
    echo "La date ou l'une des heures n'est pas spécifiée dans l'URL.";
}

// on encode la liste des stations au format json, et on l'affiche
echo json_encode($capteurs);

$db->close();
?>