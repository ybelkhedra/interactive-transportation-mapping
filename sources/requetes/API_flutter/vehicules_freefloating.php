<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");
$sql_query = "SELECT * from vehicules_freefloating;";

$return = array();
if ($result = $db->query($sql_query)) {
    while ($row = $result->fetch_assoc())
    {
        $return[] = $row;
    }
    echo json_encode($return);
} else {
    echo "Error: " . $sql_query . "<br>" . $db->error;
}
?>