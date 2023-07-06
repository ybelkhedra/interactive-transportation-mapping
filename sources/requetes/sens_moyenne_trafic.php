<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if(isset($_GET['id']) && isset($_GET['date1']) && isset($_GET['date2'])) {
    $id = $_GET['id'];
    $date1 = $_GET['date1'];
    $date2 = $_GET['date2'];
    $heure1 = $_GET['heure1'];
    $heure2 = $_GET['heure2'];

    // Requête SQL pour sélectionner les informations des capteurs et le nombre total de véhicules par classe pour la date donnée
    $sql = "SELECT
                t.id,
                t.nom,
                ROUND(AVG(daily_counts.total_vehicules)) AS moyenne_vehicules
            FROM
                trajets t
            JOIN (
                SELECT
                    capteur,
                    DATE(horodate) AS date,
                    sens,
                    COUNT(classe_vehicule) AS total_vehicules
                FROM
                    donnees_capteurs
                WHERE
                    capteur = $id
                    AND DATE(horodate) BETWEEN '$date1' AND '$date2'
                GROUP BY
                    capteur,
                    DATE(horodate),
                    sens
            ) AS daily_counts ON t.id = daily_counts.sens
            GROUP BY
                t.id,
                t.nom;
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