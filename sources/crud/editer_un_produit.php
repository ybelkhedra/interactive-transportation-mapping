<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Edition d'une donnée</title>
        <link rel="stylesheet" href="./table_style.css">
    </head>
    <body>

        <h1>Edition d'une donnée</h1>
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
if($result = mysqli_query($link, $sql)){
    if(mysqli_num_rows($result) > 0){
        echo "<table class=\"styled-table\" CELLPADDING=\"15\" >";
        echo "<tbody>";
        //recuperer la liste des colones de la table selectionnée
        $colums = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME =  '$table' order by ORDINAL_POSITION;";
        $colums = mysqli_query($link, $colums);
        //afficher le nom de chaque colonne
        echo "<tr>";
        //creer une liste des noms des colones
        $col_list = array();
        while($col = mysqli_fetch_array($colums)){
            echo "<th align=\"center\">" . $col['COLUMN_NAME'] . "</th>";
            //ajouter le nom de la colone dans la liste
            array_push($col_list, $col['COLUMN_NAME']);
        }
        echo "</tr>";

        while($row = mysqli_fetch_array($result)){
            echo "<tr>";
            echo "<form action=\"editer_un_produit.php\" method=\"GET\">";
            // nombre de colonnes
            //echo type hidden info de connection
            echo "<input type=\"hidden\" name=\"user\" value=\"". $user ."\">";
            echo "<input type=\"hidden\" name=\"password\" value=\"". $password ."\">";
            echo "<input type=\"hidden\" name=\"database\" value=\"". $database ."\">";
            echo "<input type=\"hidden\" name=\"table\" value=\"". $table ."\">";
            echo "<input type=\"hidden\" name=\"id\" value=\"". $id ."\">";
            echo "<input type=\"hidden\" name=\"colone\" value=\"". $colone ."\">";
            $nb_col = mysqli_num_fields($result);
            //pour i allant de 0 à nb_col
            for($i = 0; $i < $nb_col; $i++){
                //formulaire de modification
                echo "<td align=\"center\"><input type=\"text\" name=\"".$col_list[$i]."\" value=\"".$row[$i]."\"></td>";
            }
            echo "<input type=\"hidden\" name=\"modifier\" value=\" oui\">";
            echo "<td align=\"center\"><input type=\"submit\" value=\"Modifier\"></td>";
            echo "</form>";
            echo "</tr>";
            //si le bouton "Modifier" est appuyé alors effectuer la modification
            if(isset($_GET['modifier'])){

                //recuperer les nouvelles valeurs
                $new_values = array();
                for($i = 0; $i < $nb_col; $i++){

                    array_push($new_values, $_GET[$col_list[$i]]);
                }
                //modifier la ligne
                $sql = "UPDATE $table SET ";
                $i=0;
                while($i < $nb_col){
                    if ($new_values[$i] != ""){
                        if($i < $nb_col-1 && $i>0 || $i == $nb_col-1){
                            $sql = $sql . ", ";
                        }
                        $sql = $sql . $col_list[$i] . " = '" . $new_values[$i] . "' ";
                    }
                    $i++;
                }
                $sql = $sql . " WHERE " . $colone . " = " . $id . ";";
                //echo $sql;
                if(mysqli_query($link, $sql)){
                    echo "Modification effectuée";
                }else{
                    echo "Erreur lors de la modification";
                }
            }

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
<h2>Confirmation de l'édition</h2>
<!-- bouton oui non -->
<form action="crud.php" method="POST">
    <input type="hidden" name="user" value="<?php echo $user; ?>">
    <input type="hidden" name="password" value="<?php echo $password; ?>">
    <input type="hidden" name="database" value="<?php echo $database; ?>">
    <input type="hidden" name="table" value="<?php echo $table; ?>">
    <input type="hidden" name="id" value="<?php echo $id; ?>">
    <input type="hidden" name="colone" value="<?php echo $colone; ?>">
    <input type="submit" name="submit" value="Retour">
</form>


<?php
// si le bouton non est cliqué
// if(isset($_POST['submit']) && $_POST['submit'] == "Retour"){
//     //revenir page add_item_to_table.php avec info connection
//     header("Location: crud.php?user=$user&password=$password&database=$database&table=$table");
// }
?>

    </body>
</html>