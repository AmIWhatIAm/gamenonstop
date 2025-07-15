<?php

// Allow requests from any origin
header("Access-Control-Allow-Origin: *");
// Allow certain HTTP methods
header("Access-Control-Allow-Methods: POST, OPTIONS");
// Allow certain headers
header("Access-Control-Allow-Headers: Content-Type");

require_once 'db_config.php';

// Create a connection
$conn = getDbConnection();

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch 5 games (fixed selection)
$sql = "SELECT game_id, title, img_src FROM games ORDER BY game_id ASC LIMIT 15";
$result = $conn->query($sql);

$games = [];

if ($result->num_rows > 0) {
    // Fetch all games into an array
    while($row = $result->fetch_assoc()) {
        $games[] = [
            'game_id' => $row['game_id'],
            'title' => $row['title'],
            'img_src' => $row['img_src']
        ];
    }
}

// Return JSON response
header('Content-Type: application/json');
echo json_encode($games);

$conn->close();
?>