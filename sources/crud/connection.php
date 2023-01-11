<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>CRUD</title>
    <link rel="stylesheet" href="./table_style.css">
</head>

<body>

<!-- demande le nom d'utilisateur, le mots de passe et le nom de la base de donnée pour ensuite se connecter -->
    <form action="crud.php" method="post">
        <div class="box">
        <label for="user">Nom d'utilisateur</label>
        <input type="text" name="user" id="user">
        <label for="password">Mot de passe</label>
        <input type="password" name="password" id="password">
        <label for="database">Nom de la base de donnée</label>
        <input type="text" name="database" id="database">
        <input type="submit" value="Se connecter">
        </div>
    </form>
</body>