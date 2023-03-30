<?php 
  $db = "campus"; //database name
  $dbuser = "root"; //database username
  $dbpassword = "@Password0"; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";
  $return["success"] = false;

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  if(isset($_GET["username"]) && isset($_GET["password"])){

    if ($_GET["register"] == "false"){
       //checking if there is POST data

       $username = $_GET["username"];
       $password = $_GET["password"];
       $return["proposed_username"] = $username;
       $return["proposed_password"] = $password;


       $username = mysqli_real_escape_string($link, $username);
       //escape inverted comma query conflict from string

       $sql = "SELECT * FROM user_list WHERE username = '$username'";
       //building SQL query
       $res = mysqli_query($link, $sql);
       $numrows = mysqli_num_rows($res);
       //check if there is any row
       if($numrows > 0){
           //is there is any data with that username
           $obj = mysqli_fetch_object($res);
           //get row as object
           if(md5($password) == $obj->password){
               $return["success"] = true;
               $return["uid"] = $obj->user_id;
               $return["fullname"] = $obj->fullname;
               $return["address"] = $obj->address;
           }else{
               $return["error"] = true;
               $return["message"] = "Your Password is Incorrect.";
           }
       }else{
           $return["error"] = true;
           $return["message"] = 'No username found.';
       }
    }else{
        $username = $_GET["username"];
        $password = $_GET["password"];
        $return["proposed_username"] = $username;
        $return["proposed_password"] = $password;

        // insert new user with md5($password)
        $password = md5($password);
        $sql = "INSERT INTO user_list (username, password, fullname, email) VALUES ('$username', '$password', 'admin', 'admin@test.com')";
        $res = mysqli_query($link, $sql);
        if($res){
            $return["success"] = true;
            $return["message"] = "User created successfully.";
        }else{
            $erreur = mysqli_error($link);
            $return["error"] = true;
            $return["message"] = "Error creating user.". $erreur;
        }
    }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link);

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>