<!DOCTYPE html>
<html>
<head>
	<title>Uploader un fichier JSON</title>
</head>
<body>

    <!-- affiche la liste des fichiers json dans /uploads et permet à l'utilisateur d'en choisir un -->
<?php
    echo "Voici la liste des fichiers JSON disponibles : ";
    // affiche un formulaire qui permet a l'utilisateur d'un chosir 1
    echo "<form action='add_data_2.php' method='post'>";
    echo "<select name='json_filename'>";*
    foreach (scandir("uploads/") as $file) {
        echo "<option value='$file'>$file</option>";
    }
    echo "</select>";
    echo "<input type='submit' value='Envoyer'>";
    echo "</form>";
?>
</body>
</html>