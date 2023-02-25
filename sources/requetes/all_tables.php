<?php

// Informations de connexion à la base de données
$host = "localhost"; // Nom de l'hôte
$user = "root"; // Nom d'utilisateur de la base de données
$password = "@Password0"; // Mot de passe de la base de données
$database = "campus"; // Nom de la base de données

// Connexion à la base de données
$conn = mysqli_connect($host, $user, $password, $database);

// Vérification de la connexion
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
}

// Requête SQL pour récupérer les noms de toutes les tables de la base de données
$sql = "SHOW TABLES";
$result = mysqli_query($conn, $sql);

// Création du tableau associatif pour stocker les noms des tables
$tables = array("name" => array());
while ($row = mysqli_fetch_row($result)) {
    $tables["name"][] = $row[0];
}

// Encodage en JSON
$json = json_encode($tables);

echo $json;	

// Fermeture de la connexion
mysqli_close($conn);

?>