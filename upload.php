<?php
ini_set('memory_limit', '128M');
if(isset($_POST['submit'])) {
	$file = $_FILES['file'];

	// Vérifiez les erreurs de téléchargement
	if($file['error']) {
		echo "Une erreur s'est produite lors de l'upload du fichier.";
		exit;
	}

	// Vérifiez le type de fichier
	$fileType = pathinfo($file['name'], PATHINFO_EXTENSION);
	if($fileType != "json") {
		echo "Seuls les fichiers JSON sont autorisés.";
		exit;
	}

	// Déplacez le fichier téléchargé dans le répertoire de destination
	$uploadDir = "uploads/";
	$uploadFile = $uploadDir . basename($file['name']);
	if(move_uploaded_file($file['tmp_name'], $uploadFile)) {
		echo "Le fichier ". basename($file['name']). " a été téléchargé avec succès.";
	} else {
		echo "Une erreur s'est produite lors de l'upload du fichier.";
	}
	

		// Lisez le contenu du fichier JSON en utilisant la fonction file_get_contents
	$json = file_get_contents($uploadFile);

	// Décodez le contenu du fichier JSON en utilisant la fonction json_decode
	$data_full = json_decode($json, true);

	// Appelez la fonction findCoordinates pour trouver le chemin d'accès au dictionnaire "coordinates"
	$path = findCoordinates($data);

	// Affichez le chemin d'accès à l'utilisateur
	if($path) {
		echo "Le dictionnaire 'coordinates' a été trouvé à l'emplacement suivant: " . $path;
        eval("\$coordinates = \$data" . $path . ";");
    
    		// Vérifiez le type de données contenu dans le dictionnaire "coordinates"
            if(is_array($coordinates)) {
    			if(is_array($coordinates[0])) {
    				echo "Le dictionnaire 'coordinates' contient un tableau de tableaux.";
    			} else {
    				echo "Le dictionnaire 'coordinates' contient un tableau.";
    			}
    		} else {
    			echo "Le dictionnaire 'coordinates' ne contient pas de tableau.";
    		}
		
		
	} else {
		echo "Le dictionnaire 'coordinates' n'a pas été trouvé dans le fichier JSON.";
	}
}

// Définissez la fonction findCoordinates qui prend en entrée un tableau (qui représente les données JSON) et qui renvoie le chemin d'accès au dictionnaire "coordinates" sous forme de chaîne de caractères, ou false s'il n'est pas trouvé
function findCoordinates($data, $path = "") {
	// Parcourez chaque élément du tableau
	foreach($data as $key => $value) {
		// Si l'élément actuel est un dictionnaire "coordinates"
		if($key === "coordinates") {
			// Renvoyez le chemin d'accès au dictionnaire
			return $path . "['" . $key . "']";
		}
		// Si l'élément actuel est un tableau
		if(is_array($value)) {
			// Appelez récursivement la fonction findCoordinates sur le sous-tableau en ajoutant le nom de l'élément actuel au chemin d'accès
			$found = findCoordinates($value, $path . "['" . $key . "']");
			// Si la fonction a renvoyé un chemin d'accès (c'est-à-dire qu'un dictionnaire "coordinates" a été trouvé), renvoyez-le
			if($found) {
				return $found;
			}
		}
	}
	// Si aucun dictionnaire "coordinates" n'a été trouvé, renvoyez false
	return false;
}
?>