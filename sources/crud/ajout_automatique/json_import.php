<!DOCTYPE html>
<html>
<head>
  <title>Ajouter des données à la base de données</title>
</head>
<body>

    <?php
    // Récupération info de connection par post
    $user = $_POST['user'];
    $password = $_POST['password'];
    $database = $_POST['database'];
    ?>

  <h1>Ajouter des données à la base de données</h1>
  <form id="form-upload" method="post" action="upload.php">
    <label for="json-data">Coller le contenu de votre fichier JSON ici :</label>
    <textarea name="json-data" id="json-data" rows="10" cols="50"></textarea>
    <br>
    <label for="data-type">Sélectionner le type de données :</label>
    <select name="data-type" id="data-type">
      <option value="parkings">Parkings</option>
      <option value="points_de_charges">Points de charges</option>
      <option value="points_de_covoiturages">Points de covoiturage</option>
      <option value="stationnement_velo">Stationnement à vélo</option>
    </select>
    <br>
    <input type="hidden" name="user" value="<?php echo $user; ?>">
    <input type="hidden" name="password" value="<?php echo $password; ?>">
    <input type="hidden" name="database" value="<?php echo $database; ?>">
    <input type="submit" value="Envoyer">
  </form>
</body>
</html>