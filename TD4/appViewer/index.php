<?php

$mysqli = mysqli_connect($_ENV['DB_HOST'], $_ENV['DB_USER'], $_ENV['DB_PASS'], $_ENV['DB_NAME']);
$mysqli->set_charset("utf8");

$req_counter = "SELECT `count` FROM `counter` WHERE `id` = 1";
$res_counter = $mysqli->query($req_counter);
$counter = $res_counter->fetch_assoc()['count'];

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h1>COUNTER <?= $counter ?></h1>
</body>

</html>