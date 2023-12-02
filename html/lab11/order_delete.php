<?php
session_start();
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

$deleted = false; 
    if(isset($_Post[$_POST["cancelOrderID"]])){
    $del_stmt = $conn->prepare("CALL delete_order(?)");
    $del_stmt->bind_param('i', $_POST["cancelOrderID"]);
    $del_stmt->execute();
    $deleted = true; 
    }

    if ($deleted == true) {
        header("Location: {$_SERVER['REQUEST_URI']}", TRUE, 303);
        exit();
    }
?>
<html>
<h2>Your order has been deleted.</h2>
<p>Thank you!</p>
<?php ?>
<form action = "robotic_site.php">
    <input type = "submit" value = "Return to Home Page"/>
</form>
<?php
$orderlist = "SELECT OrderID, CONCAT(CustomerFirstName, ' ', CustomerLastName) AS 'Customer', GROUP_CONCAT(' ', DishName) AS 'Description', ROUND(SUM(DishPrice), 2) AS 'Price'
                     FROM Orders
                     INNER JOIN Customers USING (CustomerID)
                     INNER JOIN OrderDishes USING (OrderID)
                     INNER JOIN Dishes WHERE (Dishes.DishID = OrderDishes.DishID)
                     GROUP BY OrderID;";
    $OLresult = $conn->query($orderlist); 
    result_to_format_table($OLresult); 


    function result_to_format_table($result) {

        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        $num_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
        
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>
        <?php 
        for ($i=0; $i<$num_cols; $i++){ ?>
            <td><b> <?php 
                echo $fields[$i]->name; }?></b></td>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>

        <?php for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr> 
            <?php 
            for($j=0; $j<$num_cols; $j++) { ?>

                <td><?php echo $result_body[$i][$j]; ?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>
<?php
    }

?>
</html>