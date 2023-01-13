<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>CRUD</title>
    <link rel="stylesheet" href="./table_style.css">
</head>

<body>

<!-- centrer toute la page -->
<div class="center">

<?php
//recuperation info connection
$user = $_POST['user'];
$password = $_POST['password'];
$database = $_POST['database'];
?>


<!-- Selection de la table a afficher parmi un liste de choix possible {joueurs, jeux, themes} -->
    <form action="crud.php" method="post">
        <div class="box">
        <!-- <label for="table">Selectionner la table a afficher</label> -->
        <select name="table" id="table">
            <!-- valeur par default afficher au depart "selectioner une table a afficher" -->
            <option value="none" selected>Selectionner une table a afficher</option>
            <!-- recuperer le nom de toutes les tables contenus dans la base de données-->
            <?php
            $link = mysqli_connect("localhost", $user, $password, $database);

            // Vérifie si la connexion est établie
            if (!$link) {
                die("Error: Could not connect to database");
            }

            // Exécution de la requête pour récupérer les tables
            $query = "SHOW TABLES";
            $result = mysqli_query($link, $query);

            // Vérifie si la requête a renvoyé des résultats
            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_row($result)) {
                   echo "<option value=" . $row[0] . ">" . $row[0] . "</option>";
                }
            }
            ?>
        </select>
        <input type="hidden" name="user" value="<?php echo $user; ?>">
        <input type="hidden" name="password" value="<?php echo $password; ?>">
        <input type="hidden" name="database" value="<?php echo $database; ?>">
        <input type="submit" value="Afficher">
        </div>

    </form>

    <!-- Titre : Affichage de la table [NOM DE LA TABLE SELECTIONNER] -->
    <h1>Affichage de la table <?php echo $_POST['table'] ?></h1>





<?php
// connection mysql
if (!($link = mysqli_connect("localhost", $user, $password, $database)))
{
    echo "Error: Could not connect to database ==> " . mysqli_connect_error() . "";
}

// Execution de la commande sql adapté a la table selectionner
$sql = "SELECT * FROM " . $_POST['table'];
//si l'utilisateur a selecitonner une table
if (isset($_POST['table'])) {
    //si la requete a reussi
    if ($result = mysqli_query($link, $sql)) {
        if (mysqli_num_rows($result) > 0) {
            echo "<table class=\"styled-table\" CELLPADDING=\"15\" >";
            echo "<thead>";
            echo "<tr>";
            //recuperer les titres des colonnes de la table dans une liste
            $colums = mysqli_query($link, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" . $_POST['table'] . "' order by ORDINAL_POSITION;");
            //afficher le nom de chaque colonne
            while ($col = mysqli_fetch_array($colums)) {
                // la chaine "numero" est compris dans col['COLUMN_NAME'] alors nom_colone_id = col['COLUMN_NAME']
                if (strpos($col['COLUMN_NAME'], "id") !== false) {
                    $nom_colone_id = $col['COLUMN_NAME'];
                }
                echo "<th>" . $col['COLUMN_NAME'] . "</th>";
            }
            echo "</tr>";
            echo "</thead>";
            echo "<tbody>";
            while ($row = mysqli_fetch_array($result)) {
                echo "<tr>";
                //texte centré sur les colonnes
                //afficher les valeurs de toutes la table quelque soit le nom des attributs
                $nb_col = mysqli_num_fields($result);
                for ($i = 0; $i < $nb_col; $i++) {
                    echo "<td align=\"center\">" . $row[$i] . "</td>";
                }
                // a chaque fin de ligne, ajouter un bouton pour editer la ligne
                // embaler dans un classe editer
                echo "<td align=\"center\"><a class=\"editer\" href=\"editer_un_produit.php?table=" . $_POST['table'] . "&" . $nom_colone_id . "=" . $row[$nom_colone_id] . "&user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $_POST['table'] . "&id=" . $row[0] . "&colone=" . $nom_colone_id . "\">Editer</a></td>";
                // a chaque fin de ligne, ajouter un bouton pour supprimer la ligne
                echo "<td align=\"center\"><a class=\"supprimer\" href=\"supprimer_un_produit.php?user=" . $_POST['user'] . "&password=" . $_POST['password'] . "&database=" . $_POST['database'] . "&table=" . $_POST['table'] . "&id=" . $row[0] . "&colone=" . $nom_colone_id . "\">Supprimer</a></td>";
                echo "</tr>";
            }
            echo "</tbody>";
            echo "</table>";
            // Liberation du resultat
            mysqli_free_result($result);
        } else {
            echo "Aucun resultat";
        }
    } else {
        echo "Erreur impossible d'executer la commande $sql. " . mysqli_error($link);
    }
}
    // fermeture de la connection
mysqli_close($link);

?>

<div>
<!-- bouton href ajouter un item -->
<?php
if ($_POST['table'] == "produits") {
    echo "<a class=\"add_item\" href=\"add_product.php?user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $_POST['table'] . "\">Ajouter un produit</a>";
}
else 
{
    echo "<a class=\"add_item\" href=\"ajouter_un_produit.php?user=" . $user . "&password=" . $password . "&database=" . $database . "&table=" . $_POST['table'] . "\">Ajouter un item</a>";
}
?>

</div>
</div>

</html>