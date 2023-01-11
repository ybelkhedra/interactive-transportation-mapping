<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Suppression d'une donnée</title>
        <link rel="stylesheet" href="./table_style.css">
    </head>
    <body>
<div class="center">

        <h1>Suppression d'une donnée</h1>
<!-- recuperation des infos de connection -->
<?php
$user = $_GET['user'];
$password = $_GET['password'];
$database = $_GET['database'];
$table = $_GET['table'];
$id = $_GET['id'];
$colone = $_GET['colone'];
?>
<!-- Titre : recapitulatif des données selectionnées -->
<h2>Recapitulatif des données selectionnées</h2>
<!-- Affichage des données selectionnées -->

<?php
// connection mysql
$link = mysqli_connect("localhost", $user, $password, $database);
// Execution de la commande sql
$sql = "SELECT * FROM $table WHERE ".$colone ." = " .$id .";";
echo $sql;
if($result = mysqli_query($link, $sql)){
    if(mysqli_num_rows($result) > 0){
        echo "<table class=\"styled-table\" CELLPADDING=\"15\" >";
        echo "<thead>";
            echo "<tr>";
            //recuperer les titres des colonnes de la table dans une liste
            $colums = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME =  "+ $_GET['table'] + ";";
            //afficher le nom de chaque colonne
            while($row = mysqli_fetch_array($colums)){
                echo "<th align=\"center\">" . $row['COLUMN_NAME'] . "</th>";
            }
            echo "</tr>";
        echo "</thead>";
        echo "<tbody>";
        while($row = mysqli_fetch_array($result)){
            echo "<tr>";
            //texte centré sur les colonnes
            //afficher les valeurs de toutes la table quelque soit le nom des attributs
            $nb_col = mysqli_num_fields($result);
            for($i = 0; $i < $nb_col; $i++){
                echo "<td align=\"center\">" . $row[$i] . "</td>";
            }
            echo "</tr>";
        }
        echo "</tbody>";
        echo "</table>";
        // Liberation du resultat
        mysqli_free_result($result);
    } else{
        echo "Aucun resultat";
    }
} else{
    echo "Erreur impossible d'executer la commande $sql. " . mysqli_error($link);
}
?>
<!-- Titre : confirmation de la suppression -->
<h2>Confirmation de la suppression</h2>
<!-- bouton oui non -->
<form action="supprimer_un_produit.php" method="get">
    <input type="hidden" name="user" value="<?php echo $user; ?>">
    <input type="hidden" name="password" value="<?php echo $password; ?>">
    <input type="hidden" name="database" value="<?php echo $database; ?>">
    <input type="hidden" name="table" value="<?php echo $table; ?>">
    <input type="hidden" name="id" value="<?php echo $id; ?>">
    <input type="hidden" name="colone" value="<?php echo $colone; ?>">
    <input type="submit" name="submit" value="Oui">
</form>
<form action="crud.php" method="post">
    <input type="hidden" name="user" value="<?php echo $user; ?>">
    <input type="hidden" name="password" value="<?php echo $password; ?>">
    <input type="hidden" name="database" value="<?php echo $database; ?>">
    <input type="hidden" name="table" value="<?php echo $table; ?>">
    <input type="hidden" name="id" value="<?php echo $id; ?>">
    <input type="hidden" name="colone" value="<?php echo $colone; ?>">
    <input type="submit" name="submit" value="Non">
</form>

<?php
// si le bouton oui est cliqué
if(isset($_GET['submit']) && $_GET['submit'] == "Oui"){
    // connection mysql
    $link = mysqli_connect("localhost", $user, $password, $database);
    // Execution de la commande sql
    $sql = "DELETE FROM $table WHERE ". $colone ." = $id";
    if(mysqli_query($link, $sql)){
        echo "Suppression effectuée";
        // redirection vers la page precedente avec info de connection par envoi POST
        echo "<form action=\"crud.php\" method=\"post\">";
        echo "<input type=\"hidden\" name=\"user\" value=\"". $user ."\">";
        echo "<input type=\"hidden\" name=\"password\" value=\"". $password ."\">";
        echo "<input type=\"hidden\" name=\"database\" value=\"". $database ."\">";
        echo "<input type=\"hidden\" name=\"table\" value=\"". $table ."\">";
        echo "<input type=\"hidden\" name=\"id\" value=\"". $id ."\">";
        echo "<input type=\"hidden\" name=\"colone\" value=\"". $colone ."\">";
        echo "<input type=\"submit\" name=\"submit\" value=\"Retour\">";
        echo "</form>";
    } else{
        echo "Erreur impossible d'executer la commande $sql. " . mysqli_error($link);
    }
    // Fermeture de la connection
    mysqli_close($link);
}
?>
</div>
    </body>
</html>f