<?php
$ligne = $_GET['ligne'];

$db = new mysqli("localhost", "root", "@Password0", "campus");

$sql_query = "SELECT libelle from nomCommercialData where gid = $ligne;";

if ($result = $db->query($sql_query)) {
    $row = $result->fetch_assoc();
    echo $row['libelle'];
} else {
    echo "Error: " . $sql_query . "<br>" . $db->error;
}
?>