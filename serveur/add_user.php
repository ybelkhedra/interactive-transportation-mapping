<?php
// get username, password
$user = $_GET['user'];
$password = $_GET['password'];
$fullname = "admin";
$email = "admin@admin.com";

// ajouter a la table user_list de la base de donnee campus dont le mdp est le hash du mdp

// connection mysql
$link = mysqli_connect("localhost", "localhost", "@Password0", "campus");

$mdp = md5($password);

// Execution de la commande sql
$sql = "INSERT INTO user_list (user_id, username, password, fullname, email) VALUES ('1', '$user', '$mdp', '$fullname', '$email');";

if(mysqli_query($link, $sql)){
    echo "Ajout effectué";
    // redirection vers la page precedente avec info de connection par envoi POST
} else{
    echo "Erreur impossible d'executer la commande $sql. " . mysqli_error($link);
}  


// Fermeture de la connection
mysqli_close($link);

?>