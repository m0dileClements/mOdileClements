<html>
    <head>
        <title>PHP Test</title>
    </head>
    <body>
        <?php echo "Hello World!"; ?>
        <?php echo '<p>Hello World!</php>'; ?>
        
        <br>
        <?php echo $_SERVER['HTTP_USER_AGENT']; ?>
        <br>
        <?php
            if (strpos($_SERVER['HTTP_USER_AGENT'], 'Chrome') !== FALSE ) {
                echo 'You are using Chrome.';
            }
        ?>

        <?php
            if (strpos($_SERVER['HTTP_USER_AGENT'], 'Stegasaurous') !== FALSE ) {
                ?>
                <h3>strpos() returned true</h3>
                <p>You are using Chrome.<p>
                <?php
            } else {
                ?>
                <h3>strpos() returned False.</h3>
                <p>You are not using Chrome.<p>
                <?php
            }
            ?>
        <form action = "action.php" method = "post">
            <label for = "name"> Your name: </label>
            <input name = "name" id ="name" type="text">

            <label for = "age">Your age:</label>
            <input name = "age" id="age" type="number">

            <button type="submit">Submit</button>
        </form>

        <!--<?php phpinfo(); ?>-->
    </body>
</html>