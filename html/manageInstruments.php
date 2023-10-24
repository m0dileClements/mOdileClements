<h2>Here goes nothing: </h2>
<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
?>
<?php 
      $config = parse_ini_file('/home/molly/mOdileClements/mysqli.ini');
      $dbname = 'instrument_rentals';
      $conn = new mysqli(
        $config['mysqli.default_host'],
        $config['mysqli.default_user'],
        $config['mysqli.default_pw'],
        $dbname);
?>

<?php
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit;
    } else {
        echo "Connected Successfully." . "<br>";
    }
?>

<?php 
    $dblist = "SELECT instrument_id, instrument_type, student_name
                    FROM student_instruments
                    RIGHT OUTER JOIN instruments USING (instrument_id)
                    LEFT OUTER JOIN students USING (student_id);";
    $dbUsed = $conn->query($dblist); 
    result_to_html_table($dbUsed); 
    ?>

<?php 

function result_to_html_table($result) {
        // $result is a mysqli result object. This function formats the object as an
        // HTML table. Note that there is no return, simply call this function at the 
        // position in your page where you would like the table to be located.

        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        $num_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
        <p>This table has <?php echo $num_rows; ?> rows and <?php echo $num_cols; ?> columns.</p>
        
        <form action = "deleteFromTable.php" method = POST>
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>

        <?php 
        $num_cols = $num_cols +1;
        for ($i=0; $i<$num_cols; $i++){ ?>
            <td><b><?php 
                if($i == 0) {
                    ?><td>Delete? </td> <?php 
                } else {
                
                echo $fields[$i-1]->name; }?></b></td>
        <?php } ?>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>

        <?php for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr>   
            <?php 
            for($j=0; $j<$num_cols; $j++) { 
                if ($j == 0) {
                    ?> <td> <input type="checkbox"
                    name="checkbox<?php echo $id; ?>"
                    value=<?php echo $id; ?> 
                    /> </td> <?php 
                    
                } else { ?>
                <td><?php echo $result_body[$i][$j -1]; }?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>

        <input type = "submit" value = "Delete Selected Records" method = POST/>
    </form>
    <form action = "insertIntoTable.php" method = POST>
        <input type = "submit" value = "Insert Records" method = POST/>
    </form>
<?php } 



?>




<!-- <?php //for ($i=0; $i<$num_rows; $i++){ ?>
    <?php //$id = $result_body[$i][0]; ?>
            <tr>     
            <?//php for($j=0; $j<$num_cols; $j++){ ?>
                <td><?//php echo $result_body[$i][$j]; ?></td>
            <?//php } ?>
            </tr>
        <?//php } ?> -->