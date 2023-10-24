<?php
if (!$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname)){
     echo "Error: Failed to make a MySQL connection: " . "<br>";
     echo "Errno: $conn->connect_errno; i.e. $conn->connect_error \n";
     exit;
} else {
    echo "Connected!";
}
?>