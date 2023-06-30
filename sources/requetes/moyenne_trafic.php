<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if(isset($_GET['date1']) && isset($_GET['date2'])) {
    $date1 = $_GET['date1'];
    $date2 = $_GET['date2'];

    // Requête SQL pour sélectionner les informations des capteurs et le nombre total de véhicules par classe pour la date donnée
    $sql = "SELECT
                c.*,
                ROUND(AVG(daily_counts.total_vehicules)) AS moyenne_vehicules,
                ROUND(AVG(daily_counts.total_vehicules_EDPM_Trottinette)) AS moyenne_vehicules_EDPM_Trottinette,
                ROUND(AVG(daily_counts.total_vehicules_VELO)) AS moyenne_vehicules_VELO,
                ROUND(AVG(daily_counts.total_vehicules_MOTO)) AS moyenne_vehicules_MOTO,
                ROUND(AVG(daily_counts.total_vehicules_Deux_roues_2RM_2R)) AS moyenne_vehicules_Deux_roues_2RM_2R,
                ROUND(AVG(daily_counts.total_vehicules_VL)) AS moyenne_vehicules_VL,
                ROUND(AVG(daily_counts.total_vehicules_BUS)) AS moyenne_vehicules_BUS,
                ROUND(AVG(daily_counts.total_vehicules_PL)) AS moyenne_vehicules_PL,
                ROUND(AVG(daily_counts.total_vehicules_PL_1)) AS moyenne_vehicules_PL_1,
                ROUND(AVG(daily_counts.total_vehicules_PL_2)) AS moyenne_vehicules_PL_2,
                ROUND(AVG(daily_counts.total_vehicules_PL_BUS)) AS moyenne_vehicules_PL_BUS,
                ROUND(AVG(daily_counts.total_vehicules_UT)) AS moyenne_vehicules_UT,
                ROUND(AVG(daily_counts.total_vehicules_PT)) AS moyenne_vehicules_PT
            FROM
                capteurs c
            LEFT JOIN (
                SELECT
                    capteur,
                    DATE(horodate) AS date,
                    COUNT(classe_vehicule) AS total_vehicules,
                    COUNT(CASE WHEN cv.classe = 'EDPM/Trottinette' THEN classe_vehicule END) AS total_vehicules_EDPM_Trottinette,
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
                FROM
                    donnees_capteurs d
                LEFT JOIN
                    classes_vehicules cv ON d.classe_vehicule = cv.id
                WHERE
                    DATE(horodate) BETWEEN '$date1' AND '$date2'
                GROUP BY
                    capteur,
                    DATE(horodate)
            ) AS daily_counts ON c.id = daily_counts.capteur
            GROUP BY
                c.id,
                c.nom,
                c.type_capteur;
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
        echo "Aucun résultat trouvé pour les dates données.";
    }

    // Libérer la mémoire du résultat
    $result->free();
} else {
    echo "Au moins une des deux dates n'est pas spécifiée dans l'URL.";
}

// on encode la liste des stations au format json, et on l'affiche
echo json_encode($capteurs);

$db->close();
?>