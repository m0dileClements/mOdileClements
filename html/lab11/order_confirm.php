<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

  $config = parse_ini_file('/home/molly/mysqli.ini');
  $dbname = 'robo_rest_fall_2023';
  $conn = new mysqli(
    $config['mysqli.default_host'],
    $config['mysqli.default_user'],
    $config['mysqli.default_pw'],
    $dbname);

if ($conn->connect_errno) {
    echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
    echo "Errno: " . $conn->connect_errno . "\n";
    echo "Error: " . $conn->connect_error . "\n";
    exit;
};

$view_stmt = $conn->prepare("CALL add_order(?, ?, ?, ?, ?, ?, ?)");
            $view_stmt->bind_param('iiiisdd', $_POST['number0'], $_POST['number1'], $_POST['number2'], $_POST['number3'], $_POST['custName'], $_POST['custLat'], $_POST['custLong']);
            $view_stmt->execute();

?>
<html>
<h2>Your order has been submitted</h2>
<p>Thank you!</p>
<form action = "robotic_site.php">
    <input type = "submit" value = "Return to Home Page"/>
</form>
</html>