<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Ajouter un produit</title>
    <link rel="stylesheet" href="./table_style.css">
</head>

<body>
<div class="center">


<?php
//recuperation info connection
$user = $_GET['user'];
$password = $_GET['password'];
$database = $_GET['database'];
$table = $_GET['table'];
?>


<!-- recuperation des noms de colone de la $table -->
<?php
// connection mysql
$link = mysqli_connect("localhost", $_GET['user'], $_GET['password'], $_GET['database']);
//recuperation de la liste des colones de la table selectionner
$columns = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_GET['database'] . "' AND TABLE_NAME = '" . $_GET['table'] . "' order by ORDINAL_POSITION;");
?>






<!-- formulaire d'ajout d'item en fonction des colones de la table selectionnée  -->
<form action="ajouter_un_produit.php" method="get">
    <?php
    $tmp=0;
    // affichage des input pour chaque colone de la table selectionner
    while ($column = mysqli_fetch_array($columns)) {
        if ($tmp>0){
        echo "<label for='" . $column['COLUMN_NAME'] . "'>" . $column['COLUMN_NAME'] . "</label>";
        echo "<input type='text' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
        }
        $tmp++;
    }
    ?>
    <input type="hidden" name="user" value="<?php echo $user; ?>">
    <input type="hidden" name="password" value="<?php echo $password; ?>">
    <input type="hidden" name="database" value="<?php echo $database; ?>">
    <input type="hidden" name="table" value="<?php echo $table; ?>">
    <input type="hidden" name="modifier" value=" oui">
    <?php
    if (isset($_GET['add_product'])) {
        echo "<input type='hidden' name='add_product' value='1'>";
    }
    ?>
    <input type="submit" value="Ajouter">
</form>





<!-- Si le bouton ajouter est appuyer on ajoute les données à la table selectionnée -->
<?php
if (isset($_GET['modifier'])) {
    //recuperer les nouvelles valeurs des colones
    $columns = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_GET['database'] . "' AND TABLE_NAME = '" . $_GET['table'] . "' order by ORDINAL_POSITION;");
    //ajouter les nouvelles valeurs dans la table selectionner pour les colones selectionner sauf la premiere
    $query = "INSERT INTO " . $_GET['table'] . "(";
    $cpt=0;
    while ($column = mysqli_fetch_array($columns)) {
        if ($cpt>0) {
            $query = $query . $column['COLUMN_NAME'] . ",";
        }
        $cpt++;
    }
    //si query termine par une virgule on la supprime
    if (substr($query, -1) == ",") {
        $query = substr($query, 0, -1);
    }
    $query = $query. ") VALUES ( ";
    $columns = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_GET['database'] . "' AND TABLE_NAME = '" . $_GET['table'] . "' order by ORDINAL_POSITION;");
    $cpt=0;
    while ($column = mysqli_fetch_array($columns)) {
        if ($cpt>0) {
            if ($_GET[$column['COLUMN_NAME']] != ""){
            $query = $query . "'" . $_GET[$column['COLUMN_NAME']] . "',";
            }
            else{
                $query = $query . "NULL,";
            }
        }
        $cpt++;
    }
    $query = substr($query, 0, -1);
    $query = $query . ");";
    // execution de la requete d'ajout
    if (mysqli_query($link, $query)) {
        echo "Item ajouté";

        //recuperer l'id de l'item ajouter
        $query = "SELECT MAX(id) FROM " . $_GET['table'] . ";";
        $result = mysqli_query($link, $query);
        $row = mysqli_fetch_array($result);
        $id_table = $row[0];
        
        // formulaire POST vers ajout_emplacement.php avec info de connection, table et id_table
        echo "<form action='ajout_emplacement.php' method='post'>";
        echo "<input type='hidden' name='user' value='" . $user . "'>";
        echo "<input type='hidden' name='password' value='" . $password . "'>";
        echo "<input type='hidden' name='database' value='" . $database . "'>";
        echo "<input type='hidden' name='table' value='" . $table . "'>";
        echo "<input type='hidden' name='id_table' value='" . $id_table . "'>";
        echo "<input type='submit' value='Ajouter un emplacement'>";

        //retour page precedente avec info connection
        //if (isset($_GET['add_product'])) {
        //    echo "<a href='add_product.php?user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $table . "&add_product=1'>Retour</a>";
        //} else {
            //echo "<a href='crud.php?user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $table . "'>Retour</a>";
        //}
    }
    else
    {
        echo "Erreur lors de l'ajout de l'item";
        //affichage de l'erreur sql
    }
    mysqli_close($link);
}
?>


<!-- bouton retour -->
<?php 
if (isset($_GET['add_product'])) {
    //dans une classe nommé "bouton_retour" dans le css
    echo "<a class='bouton_retour' href='add_product.php?user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $table . "&add_product=1'>Retour</a>"; 
} else {
    echo "<form action=\"crud.php\" method=\"post\">";
    echo "<input type=\"hidden\" name=\"user\" value=\"". $user ."\">";
    echo "<input type=\"hidden\" name=\"password\" value=\"". $password ."\">";
    echo "<input type=\"hidden\" name=\"database\" value=\"". $database ."\">";
    echo "<input type=\"hidden\" name=\"table\" value=\"". $table ."\">";
    echo "<input type=\"submit\" name=\"submit\" value=\"Retour\">";
    echo "</form>";
    //echo "<a class='bouton_retour' href='crud.php?user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $table . "'>Retour</a>";
}
?>
</div>
</body>


</html>