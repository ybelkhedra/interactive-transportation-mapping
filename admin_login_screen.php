<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="./admin_login_screen.css">
</head>
<body>
    <div class="loginbox">
        <h1>Connexion administrateur</h1>
        <form action="admin_login_screen.php" method="post">
            <p>Identifiant</p>
            <input type="text" name="identifiant" placeholder="Entrer votre identifiant" required>
            <p>Password</p>
            <input type="password" name="mot de passe" placeholder="Entrer votre mot de passe" required>
            <input type="submit" name="submit" value="Connexion">
        </form>
    </div>
</body>
</html>
