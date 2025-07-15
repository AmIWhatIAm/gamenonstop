<?php
define('DB_HOST', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'gns');

// Optional: Create a connection function
function getDbConnection() {
    $conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
    
    if (!$conn) {
        die('Could not connect to the database: ' . mysqli_connect_error());
    }
    
    return $conn;
}
?>