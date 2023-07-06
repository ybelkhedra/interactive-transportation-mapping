<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if(isset($_GET['id']) && isset($_GET['date'])) {
    $id = $_GET['id'];
    $date = $_GET['date'];

    // Requête SQL pour sélectionner les informations des capteurs et le nombre total de véhicules par classe pour la date donnée
    $sql = "SELECT
                dc.sens,
                t.nom,
                COUNT(dc.classe_vehicule) AS total_vehicules
            FROM donnees_capteurs dc
            JOIN trajets t ON dc.sens = t.id
            WHERE dc.capteur = $id
                AND DATE(dc.horodate) = '$date'
            GROUP BY dc.sens, t.nom;
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
    echo "La date n'est pas spécifiée dans l'URL.";
}

// on encode la liste des stations au format json, et on l'affiche
echo json_encode($capteurs);

$db->close();
?>