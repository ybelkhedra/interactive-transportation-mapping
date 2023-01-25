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
$user = $_POST['user'];
$password = $_POST['password'];
$database = $_POST['database'];
$table = $_POST['table'];
?>


<!-- recuperation des noms de colone de la $table -->
<?php
// connection mysql
$link = mysqli_connect("localhost", $_POST['user'], $_POST['password'], $_POST['database']);
//recuperation de la liste des colones de la table selectionner
$columns = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_POST['database'] . "' AND TABLE_NAME = '" . $_POST['table'] . "' order by ORDINAL_POSITION;");
?>






<!-- formulaire d'ajout d'item en fonction des colones de la table selectionnée  -->
<form action="ajouter_un_produit.php" method="post">
    <?php
    $tmp=0;
    // affichage des input pour chaque colone de la table selectionner
    while ($column = mysqli_fetch_array($columns)) {
        if ($tmp>0){
        echo "<label for='" . $column['COLUMN_NAME'] . "'>" . $column['COLUMN_NAME'] . "</label>";
        //determiner le type de la colone (int, text, date, boolean, etc ...)
        $type = mysqli_query($link, "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_POST['database'] . "' AND TABLE_NAME = '" . $_POST['table'] . "' AND COLUMN_NAME = '" . $column['COLUMN_NAME'] . "';");
        $type = mysqli_fetch_array($type);
        $type = $type['DATA_TYPE'];
        //si la colone est un boolean on affiche un select
        if ($type == "tinyint") {
            echo "<select name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'>";
            echo "<option value='0'>Non</option>";
            echo "<option value='1'>Oui</option>";
            echo "</select><br>";
        }
        //si la colone est un int on affiche un input type number
        elseif ($type == "int") {
            echo "<input type='number' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
        }
        //si la colone est un float on affiche un input type number
        elseif ($type == "float") {
            echo "<input type='number' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
        }
        //si la colone est un date on affiche un input type date
        elseif ($type == "date") {
            echo "<input type='date' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
        }
        //si la colone est un datetime on affiche un input type datetime-local
        elseif ($type == "datetime") {
            echo "<input type='datetime-local' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
        }
        //si la colone est un text on affiche un input type text
        elseif ($type == "text") {
            echo "<input type='text' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
        } 
        else {
                echo "<input type='text' name='" . $column['COLUMN_NAME'] . "' id='" . $column['COLUMN_NAME'] . "'><br>";
            }
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
    if (isset($_POST['add_product'])) {
        echo "<input type='hidden' name='add_product' value='1'>";
    }
    ?>
    <input type="submit" value="Ajouter">
</form>





<!-- Si le bouton ajouter est appuyer on ajoute les données à la table selectionnée -->
<?php
if (isset($_POST['modifier'])) {
    //recuperer les nouvelles valeurs des colones
    $columns = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_POST['database'] . "' AND TABLE_NAME = '" . $_POST['table'] . "' order by ORDINAL_POSITION;");
    //ajouter les nouvelles valeurs dans la table selectionner pour les colones selectionner sauf la premiere
    $query = "INSERT INTO " . $_POST['table'] . "(";
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
    $columns = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '" . $_POST['database'] . "' AND TABLE_NAME = '" . $_POST['table'] . "' order by ORDINAL_POSITION;");
    $cpt=0;
    while ($column = mysqli_fetch_array($columns)) {
        if ($cpt>0) {
            if ($_POST[$column['COLUMN_NAME']] != ""){
            $query = $query . "'" . $_POST[$column['COLUMN_NAME']] . "',";
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
        $query = "SELECT MAX(id) FROM " . $_POST['table'] . ";";
        $result = mysqli_query($link, $query);
        $row = mysqli_fetch_array($result);
        $id_table = $row[0];
        
        // formulaire POST vers ajout_emplacement.php avec info de connection, table et id_table
        // echo "<form action='ajout_emplacement.php' method='post'>";
        // echo "<input type='hidden' name='user' value='" . $user . "'>";
        // echo "<input type='hidden' name='password' value='" . $password . "'>";
        // echo "<input type='hidden' name='database' value='" . $database . "'>";
        // echo "<input type='hidden' name='table' value='" . $table . "'>";
        // echo "<input type='hidden' name='id_table' value='" . $id_table . "'>";
        // echo "<input type='submit' value='Ajouter un emplacement'>";

        //retour page precedente avec info connection
        //if (isset($_POST['add_product'])) {
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
if (isset($_POST['add_product'])) {
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