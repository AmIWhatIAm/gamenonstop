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

if ($_SERVER["REQUEST_METHOD"] == "POST"){
    // Get JSON input (if sent as JSON)
    $input = json_decode(file_get_contents('php://input'), true);
    
    // Check if data comes from POST or JSON
    $user_id = $input['user_id'] ?? $_POST['user_id'] ?? null;
    $game_list = $input['game_list'] ?? $_POST['game_list'] ?? null;
    $total_amount = $input['total_amount'] ?? $_POST['total_amount'] ?? null;
    $payment_method = $input['payment_method'] ?? $_POST['payment_method'] ?? null;
    
    // Validate required fields
    if (empty($user_id) || empty($game_list) || empty($total_amount) || empty($payment_method)) {
        echo json_encode([
            'success' => false, 
            'error' => 'Missing required fields',
            'debug' => [
                'user_id' => $user_id,
                'game_list' => $game_list,
                'total_amount' => $total_amount,
                'payment_method' => $payment_method
            ]
        ]);
        exit();
    }
    
    // Parse game_list if it's a string
    if (is_string($game_list)) {
        $game_list = json_decode($game_list, true);
    }
    
    // Validate game_list
    if (!is_array($game_list) || empty($game_list)) {
        echo json_encode(['success' => false, 'error' => 'Invalid game list']);
        exit();
    }
    
    $purchase_date = date('Y-m-d H:i:s'); // Include time for better tracking
    
    try {
        // Create connection
        $conn = getDbConnection();
        
        // Start transaction
        mysqli_begin_transaction($conn);
        
        // Insert data into purchases table using prepared statement
        $sql = "INSERT INTO purchases (user_id, purchase_date, total_amount, payment_method) VALUES (?, ?, ?, ?)";
        $stmt = mysqli_prepare($conn, $sql);
        
        if (!$stmt) {
            throw new Exception("Prepare failed: " . mysqli_error($conn));
        }
        
        mysqli_stmt_bind_param($stmt, 'isds', $user_id, $purchase_date, $total_amount, $payment_method);
        
        if (!mysqli_stmt_execute($stmt)) {
            throw new Exception("Execute failed: " . mysqli_stmt_error($stmt));
        }
        
        // Get the last inserted purchase_id
        $purchase_id = mysqli_insert_id($conn);
        
        if (!$purchase_id) {
            throw new Exception("Failed to get purchase ID");
        }
        
        // Insert each game into purchase_items table
        $item_sql = "INSERT INTO purchase_items (purchase_id, game_id) VALUES (?, ?)";
        $item_stmt = mysqli_prepare($conn, $item_sql);
        
        if (!$item_stmt) {
            throw new Exception("Prepare item statement failed: " . mysqli_error($conn));
        }
        
        foreach ($game_list as $game) {
            $game_id = $game["game_id"] ?? null;
            
            if (!$game_id) {
                throw new Exception("Invalid game ID in game list");
            }
            
            mysqli_stmt_bind_param($item_stmt, 'ii', $purchase_id, $game_id);
            
            if (!mysqli_stmt_execute($item_stmt)) {
                throw new Exception("Failed to insert game item: " . mysqli_stmt_error($item_stmt));
            }
        }
        
        // Commit transaction
        mysqli_commit($conn);
        
        echo json_encode([
            "success" => true, 
            "message" => "Purchase made successfully",
            "purchase_id" => $purchase_id,
            "games_purchased" => count($game_list)
        ]);
        
    } catch (Exception $e) {
        // Rollback transaction on error
        mysqli_rollback($conn);
        
        echo json_encode([
            'success' => false, 
            'error' => 'Purchase failed: ' . $e->getMessage()
        ]);
    } finally {
        // Close statements and connection
        if (isset($stmt)) mysqli_stmt_close($stmt);
        if (isset($item_stmt)) mysqli_stmt_close($item_stmt);
        if (isset($conn)) mysqli_close($conn);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid request method']);
}
?>