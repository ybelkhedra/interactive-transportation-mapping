<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query(" SELECT stop_id, stop_lat, stop_lon, stop_name FROM stop;")) {
    while ($row = $result->fetch_assoc()) {
        $row = array_merge($row, array("ligne_car" => array()));
        // echo "SELECT route_short_name, route_long_name FROM routes WHERE route_id IN (SELECT route_id FROM trips WHERE trip_id IN (SELECT trip_id FROM stop_times WHERE stop_id = ".$row['stop_id']."));\n\n";
        if ($result2 = $db->query("SELECT route_short_name, route_long_name FROM routes WHERE route_id IN (SELECT route_id FROM trips WHERE trip_id IN (SELECT trip_id FROM stop_times WHERE stop_id = ".$row['stop_id']."));"))
        {
            while ($row2 = $result2->fetch_assoc()) {
                $row['ligne_car'][] = [$row2['route_short_name'], $row2['route_long_name']];
            }
            $result2->free();
        }
        $res[] = $row;
    }
    $result->free();
}
echo json_encode($res);
$db->close();

?>
