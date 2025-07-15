<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'db_config.php';

// Allow requests from any origin
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Handle both JSON and form data
    $input = json_decode(file_get_contents('php://input'), true);
    $user_id = $input['user_id'] ?? $_POST['user_id'] ?? null;
    
    if (!$user_id || empty($user_id)) {
        echo json_encode(['success' => false, 'error' => 'User ID is missing.']);
        exit();
    }

    $user_id = (int)$user_id;

    try {
        // Create connection
        $conn = getDbConnection();

        if (!$conn) {
            throw new Exception('Could not connect to the database: ' . mysqli_connect_error());
        }

        // Use a single optimized query with JOINs
        $sql = "SELECT DISTINCT g.game_id, g.img_src, g.title, g.price 
                FROM games g 
                INNER JOIN purchase_items pi ON g.game_id = pi.game_id 
                INNER JOIN purchases p ON pi.purchase_id = p.purchase_id 
                WHERE p.user_id = ? 
                ORDER BY g.title";
        
        $stmt = mysqli_prepare($conn, $sql);
        
        if (!$stmt) {
            throw new Exception("Prepare failed: " . mysqli_error($conn));
        }
        
        mysqli_stmt_bind_param($stmt, 'i', $user_id);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        $game_purchased = [];
        
        if (mysqli_num_rows($result) > 0) {
            while ($row = mysqli_fetch_assoc($result)) {
                $game_purchased[] = [
                    'game_id' => $row['game_id'],
                    'title' => $row['title'],
                    'img_src' => $row['img_src'],
                    'price' => $row['price']
                ];
            }
            
            echo json_encode([
                'success' => true, 
                'message' => 'Games found', 
                'game_list' => $game_purchased,
                'count' => count($game_purchased)
            ]);
        } else {
            echo json_encode([
                'success' => false, 
                'error' => 'No games purchased.',
                'game_list' => []
            ]);
        }

        mysqli_stmt_close($stmt);
        mysqli_close($conn);
        
    } catch (Exception $e) {
        echo json_encode([
            'success' => false, 
            'error' => 'Database error: ' . $e->getMessage()
        ]);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid request method.']);
}
?>