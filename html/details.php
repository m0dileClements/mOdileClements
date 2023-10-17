<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
?>

<?php $dbhost = 'localhost';
      $dbuser = 'molly';
      $dbpass = 'dragon';
      $dbname = $_GET['name'];
      $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
?>

<?php
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit;
    } else {
        echo "Connected Successfully!" . "<br>";
        echo "YAY!" . "<br>";
    }
?>
<?php
    $dblist = "SHOW tables" ;
    $result = $conn->query($dblist);
    
?>

Your database tables are: 
<br> <ul>
<?php
 $dbn = "Tables_in_" .  $dbname;
  while ($tablename = $result->fetch_array()) {
    echo $tablename[$dbn] . "<br>";
    ?>
    <?php
    }
    $conn->close();
?>
