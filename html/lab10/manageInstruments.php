<?php
    session_start();

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
    //varaibles to flag if an object has been inserted, deleted or changed
    $deleted = false;
    $inserted = false;
    $session_logout = false;
    $session_name = false;
    $styled = false;
    
    if (!isset($_COOKIE['style'])){
        setcookie("style", 0, time()+60*30, "/", "", false, true);
    }

    if(isset($_POST['style'])) {
        $style = 0;
        if ($_COOKIE['style'] == 0){
            $style = 1;
        }
        if ($_COOKIE['style'] == 1){
            $style = 0;
        }
        setcookie("style", $style, time()+60*30, "/", "", false, true);
        $styled = true;
    }
    
    
    //deletion for selected items in last post request
    for($i = 0; $i < $result->num_rows; $i++){
        $id = $resrows[$i][0];
        $key = "checkbox" . $id;
        if (isset($_POST[$key]) ){
            $deleted = true;
            $_SESSION["counter"] += + 1;
            $del_stmt->execute(); 
        }
    }
    // Insertion of set items
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

    if (isset($_POST['name'])) {
        $session_name = true;
        $_SESSION['name'] = $_POST['name'];
        $_SESSION['view'] = true;
    }

    
    //counting for the number of deleted items

    if (!isset($_SESSION["counter"])){
        $_SESSION["counter"] = 0;
    }

    if(!isset($_SESSION["view"])){
        $_SESSION["view"] = false;
    }
    
    //logs out the user when the 'Log out' button is pressed
    if (isset($_POST['Session'])){
        $session_logout = true;
        setcookie("style", 0, time()+60*30, "/", "", false, true);
        session_unset();
        session_destroy();
    }
    if ($deleted == true || $inserted == true|| $session_logout == true || $session_name == true || $styled == true) {
    header("Location: {$_SERVER['REQUEST_URI']}", TRUE, 303);
    exit();
    }
?>
<html>
<?php 


if(($_COOKIE['style']) == 0) {?>
    <link rel = "stylesheet" href = "default.css">
<?php
} 
if (($_COOKIE['style']) == 1) { ?>
    <link rel = "stylesheet" href = "darkMode.css">
<?php
}
?>


<h2>Student Instrument Records</h2>

    <?php if ($_SESSION["view"] == false) { ?>
    <form action = "manageInstruments.php" method = POST>
        <label for = "name">Name: </label>
        <input name = "name" id ="name" type="text">
        <button type="submit">Submit</button>
    </form>
<?php }
     if ($_SESSION["view"] == true) { ?>

    </html> 
    
    <p> <?php
    echo "Hello ". $_SESSION["name"]; 
    
    }
    ?> </p>

    <br>
    <form action = "manageInstruments.php" method = POST>
    <input type = "submit" value = "Switch Mode" name = "style"/>
    </form>
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

        <input type = "submit" value = "Delete Selected Records" 
        method = POST/>
    </form>
    
<?php 
} ?>

<p>You have deleted <?php echo $_SESSION["counter"];?> record(s) this session</p>
<i>Logging out will clear this counter</i>
<form action = "manageInstruments.php" method = POST>
    <input type = "submit" value = "Log out" name = "Session"/>
    </form>

<form action = "manageInstruments.php" method = POST>
    <input type = "submit" value = "Insert Records" name = "Insert"/>
    </form>