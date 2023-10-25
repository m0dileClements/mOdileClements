<?php   
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    $config = parse_ini_file('/home/molly/mOdileClements/mysqli.ini');
      $dbname = 'instrument_rentals';
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

    $dblist = "SELECT instrument_id, instrument_type, student_name
                    FROM student_instruments
                    RIGHT OUTER JOIN instruments USING (instrument_id)
                    LEFT OUTER JOIN students USING (student_id);";
    $result = $conn->query($dblist); 
    $resrows = $result->fetch_all();


    $del_stmt = $conn->prepare("DELETE FROM instruments WHERE instrument_id = ?;");
    $del_stmt->bind_param('i', $id);
    $deleted = false;
    $inserted = false;
    
    
    for($i = 0; $i < $result->num_rows; $i++){
        $id = $resrows[$i][0];
        $key = "checkbox" . $id;
        if (isset($_POST[$key]) ){
            $deleted = true;
            $del_stmt->execute(); 
        }
    }
    if (isset($_POST['Insert'])){
       $inserted = true;
            $conn->query("INSERT INTO instruments (instrument_type)
            VALUES ('Guitar'),
                   ('Trumpet'),
                   ('Flute'),
                   ('Theramin'),
                   ('Violin'),
                   ('Tuba'),
                   ('Melodica'),
                   ('Trombone'),
                   ('Keyboard'); "); 
    }


    if ($deleted == true || $inserted == true) {
    header("Location: {$_SERVER['REQUEST_URI']}", TRUE, 303);
    exit();
    }
?>
<h2>Student Instrument Records</h2>


<?php 
    $dblist = "SELECT instrument_id, instrument_type, student_name
                FROM student_instruments
                RIGHT OUTER JOIN instruments USING (instrument_id)
                LEFT OUTER JOIN students USING (student_id);";
    $result = $conn->query($dblist); 
    result_to_html_table($result); 
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
        
        <form action = "manageInstruments.php" method = POST>
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>
        <td>Delete?</td>
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
            <td> <input type="checkbox"
                    name="checkbox<?php echo $id; ?>"
                    value=<?php echo $id; ?> 
                    /> </td>  
            <?php 
            for($j=0; $j<$num_cols; $j++) { ?>

                <td><?php echo $result_body[$i][$j]; ?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>

        <input type = "submit" value = "Delete Selected Records" method = POST/>
    </form>
    
<?php 
} ?>

<form action = "manageInstruments.php" method = POST>
    <input type = "submit" value = "Insert Records" name = "Insert"/>
    </form>