<!DOCTYPE html>
<html>
<head>
	<title>Uploader un fichier JSON</title>
</head>
<body>
<?php
function detect_array_type($arr) {
    if (is_array($arr)) {
        $array_type = "simple";
        foreach ($arr as $item) {
            if (is_array($item)) {
                $array_type = "array of arrays";
                break;
            }
        }
    } else {
    $array_type = "not an array";
    }
    return $array_type;
}

function get_coordinates_path($json_string) {
    $json_data = json_decode($json_string, true);
    $coordinates_path = array();
    function find_coordinates($data, $path) {
        if (is_array($data)) {
            foreach ($data as $key => $value) {
                if ($key == "coordinates") {
                    array_push($coordinates_path, $path, $key);
                    return;
                } 
                else {
                    find_coordinates($value, array_merge($path, [$key]));
                }
            }
        }
    }
    find_coordinates($json_data, array());
    if (!empty($coordinates_path)) {
        return $coordinates_path;
    } 
    else {
        return NULL;
    }
}


    // recupere le nom du fichier json et l'ouvre
    $json_filename = $_POST['json_filename'];
    $json_file = fopen("uploads/$json_filename", "r");
    $json_string = file_get_contents("uploads/" . $json_file);
    fclose($json_file);
    $coordinates_path_str = get_coordinates_path($json_string);
    // Enlève tout ce qui est avant le premier point
    $coordinates_path_str = substr($coordinates_path_str, strpos($coordinates_path_str, ".") + 1);
    // Trouve la première occurence de "coordinates" dans $coordinates_path
    // regarde si se qui est contenue dans le dictionnaire coordinates est un tableau simple ou un tableau de tableau
?>
</body>
</html>