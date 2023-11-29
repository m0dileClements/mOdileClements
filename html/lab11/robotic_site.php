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
        
        
        
        $dishlist = "SELECT DishName AS 'Item', DishPrice  AS 'Price'
                    FROM Dishes;";
        $result = $conn->query($dishlist); 
        $resrows = $result->fetch_all();

        $orderlist = "SELECT OrderID, CONCAT(CustomerFirstName, ' ', CustomerLastName) AS 'Customer', GROUP_CONCAT(' ', DishName) AS 'Description', ROUND(SUM(DishPrice), 2) AS 'Price'
                        FROM Orders
                        INNER JOIN Customers USING (CustomerID)
                        INNER JOIN OrderDishes USING (OrderID)
                        INNER JOIN Dishes WHERE (Dishes.DishID = OrderDishes.DishID)
                        GROUP BY OrderID;";
        $OLresult = $conn->query($orderlist);
        $OLresrows = $result->fetch_all();

        $deleted = false;

        if(isset($_POST['cancelOrderID'])) {
            $deleted = true;
            $del_stmt = $conn->prepare("CALL delete_order(?)");
            $del_stmt->bind_param('i', $_POST["cancelOrderID"]);
            $del_stmt->execute();

        }

        if ($deleted == true) {
            header("Location: {$_SERVER['REQUEST_URI']}", TRUE, 303);
            exit();
        }
        

    ?>
    <!DOCTYPE html>
    <head>
        <title>Place an Order</title>
    </head>
    <body>
    <?php ?>
    
    <h1>Welcome to Alice's <code>Robotic</code> Restaurant</h1>
    <p>You can <code>grep</code> anything you want from Alice's restaurant.</p>
   
    <form action="order_confirm.php" method="POST" name= "ordered">

    <h2>Menu</h2>
    <?php
    $dishlist = "SELECT DishName AS 'Item', DishPrice AS 'Price'
                FROM Dishes;";
    $result = $conn->query($dishlist); 
    result_to_input_table($result); 
    ?>
    
    
<?php  
function result_to_input_table($result) {


$result_body = $result->fetch_all();
$num_rows = $result->num_rows;
$num_cols = $result->field_count;
$fields = $result->fetch_fields();
?>
<!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
<!-- <p>This table has <?php echo $num_rows; ?> rows and <?php echo $num_cols; ?> columns.</p> -->

<form action = "robotic_site.php" method = POST>
    

<!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
<table>
<thead>
<tr>
<td><b>Quantity</b></td>
<?php 
for ($i=0; $i<$num_cols; $i++){ ?>
    <td><b> <?php 
        echo $fields[$i]->name; }?></b></td>
</tr>
</thead>

<!-- Begin body - - - - - - - - - - - - - - - value=<? //php echo $id; ?>- - - - - - -->
<tbody>

<?php for ($i=0; $i<$num_rows; $i++){ ?>
    <?php $id = $result_body[$i][0]; ?>
    <tr> 
    <td> <input type="number"
            name="number<?php echo $id; ?>" min = "0" max="20" value= 0 placeholder = 0
            /> </td>  
    <?php 
    for($j=0; $j<$num_cols; $j++) { ?>

        <td><?php echo $result_body[$i][$j]; ?></td>
    <?php } ?>
    </tr>
<?php } ?>
</tbody></table>
    <table>
    <tr>
        <td>
            <label for = "custName">Name: </label>
        </td> <td>
            <input name = "custName" id ="custName" type="text" required>
        </td>
    </tr>
    <tr>
        <td>
            <label for = "custLat">Latitude: </label>
        </td> <td>
            <input name = "custLat" id ="custLat" type="text">
        </td>
    </tr>
    
    <tr>
        <td>
            <label for = "custLong">Longitude: </label>
        </td> <td>
            <input name = "custLong" id ="custLong" type="text">
        </td>
    </tr>
    </table>
    
<input type = "submit" value = "Place Order" 
method = POST/>
</form>

<?php 
} ?>
<h2>Cancel an Order</h2>
<form action = "order_delete.php" method = POST>
    <table>
        <tr>
            <td>
                <label for = "cancelOrderID">OrderId: </label>
            </td> <td>
                <input name = "cancelOrderID" id ="cancelOrderID" type="text">
            </td>
        </tr>
    </table>
    <input type = "submit" value = "Cancel Order" method = POST/>
</form>
<h2>Pending Orders</h2>
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
   
</body>
</html>