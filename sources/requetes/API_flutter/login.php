<?php 
  $db = "campus"; 
  $dbuser = "root";
  $dbpassword = "@Password0";
  $dbhost = "localhost";

  $return["error"] = false;
  $return["message"] = "";
  $return["success"] = false;

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  if(isset($_GET["username"]) && isset($_GET["password"])){

    if ($_GET["register"] == "false"){

       $username = $_GET["username"];
       $password = $_GET["password"];
       $return["proposed_username"] = $username;
       $return["proposed_password"] = $password;


       $username = mysqli_real_escape_string($link, $username);
       //évidement du conflit de requête entre virgules inversées dans la chaîne de caractères

       $sql = "SELECT * FROM user_list WHERE username = '$username'";
       $res = mysqli_query($link, $sql);
       $numrows = mysqli_num_rows($res);
       if($numrows > 0){
           $obj = mysqli_fetch_object($res);
           if(md5($password) == $obj->password){
               $return["success"] = true;
               $return["uid"] = $obj->user_id;
               $return["fullname"] = $obj->fullname;
               $return["address"] = $obj->address;
           }else{
               $return["error"] = true;
               $return["message"] = "Mot de passe incorrect.";
           }
       }else{
           $return["error"] = true;
           $return["message"] = 'Login incorrect.';
       }
    }else{
        $username = $_GET["username"];
        $password = $_GET["password"];
        $return["proposed_username"] = $username;
        $return["proposed_password"] = $password;

        $password = md5($password);
        $sql = "INSERT INTO user_list (username, password, fullname, email) VALUES ('$username', '$password', 'admin', 'admin@test.com')";
        $res = mysqli_query($link, $sql);
        if($res){
            $return["success"] = true;
            $return["message"] = "Utilisateur créé avec succes.";
        }else{
            $erreur = mysqli_error($link);
            $return["error"] = true;
            $return["message"] = "Erreur creation de l'utilisateur.". $erreur;
        }
    }
  }else{
      $return["error"] = true;
      $return["message"] = 'Parametre(s) manquant(s).';
  }

  mysqli_close($link);

  header('Content-Type: application/json'); // On indique que le contenu est du JSON au navigateur
  echo json_encode($return);
?>