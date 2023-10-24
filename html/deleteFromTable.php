<?php
if (!$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname)){
     echo "Error: Failed to make a MySQL connection: " . "<br>";
     echo "Errno: $conn->connect_errno; i.e. $conn->connect_error \n";
     exit;
    
}
?>


<?php

$del_stmt = $conn->prepare("DELETE FROM instruments WHERE instrument_id = ?;");
$del_stmt->bind_param('i', $id);

for($i = 0; $i < $result->num_rows; $i++){
    $id = $resrows[$i][0];
    $key = "checkbox" . $id;
    if (isset($_POST[$key]) ){

        if($del_stmt -> execute()){
            $del_stmt->execute(); 
            header($_SERVER["REQUEST_URI"], TRUE, 303);
        }
        else {
            echo $conn->error;
        }
        
    }
}

 
quit();
?>
