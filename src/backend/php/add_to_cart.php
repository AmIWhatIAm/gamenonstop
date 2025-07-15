<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

// Include database configuration
require_once 'db_config.php';

// CORS headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Start session with proper configuration
session_start();

// Set session cookie parameters for localhost
ini_set('session.cookie_path', '/');
ini_set('session.cookie_domain', 'localhost');
ini_set('session.cookie_secure', 0); // Set to 1 for HTTPS
ini_set('session.cookie_httponly', 1);

// Function to get game details from database
function getGameDetails($game_id) {
    $conn = getDbConnection();
    
    $sql = "SELECT game_id, title, price, img_src FROM games WHERE game_id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, 's', $game_id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    
    $game = mysqli_fetch_assoc($result);
    mysqli_close($conn);
    
    return $game;
}

// Function to add item to cart
function addToCart($game_id) {
    // Initialize cart if not exists
    if (!isset($_SESSION['cart'])) {
        $_SESSION['cart'] = array();
    }
    
    // Check if game already in cart
    if (isset($_SESSION['cart'][$game_id])) {
        return [
            'success' => false,
            'message' => 'Game already in cart',
            'cart_count' => count($_SESSION['cart'])
        ];
    }
    
    // Get game details from database
    $game = getGameDetails($game_id);
    
    if (!$game) {
        return [
            'success' => false,
            'message' => 'Game not found',
            'cart_count' => count($_SESSION['cart'])
        ];
    }
    
    // Add game to cart with details
    $_SESSION['cart'][$game_id] = [
        'game_id' => $game['game_id'],
        'title' => $game['title'],
        'price' => $game['price'],
        'img_src' => $game['img_src'],
        'quantity' => 1,
        'added_at' => date('Y-m-d H:i:s')
    ];
    
    return [
        'success' => true,
        'message' => 'Game added to cart successfully',
        'game' => $_SESSION['cart'][$game_id],
        'cart_count' => count($_SESSION['cart'])
    ];
}

// Function to get cart contents
function getCartContents() {
    $cart = isset($_SESSION['cart']) ? $_SESSION['cart'] : array();
    $total = 0;
    
    foreach ($cart as $item) {
        $total += $item['price'] * $item['quantity'];
    }
    
    return [
        'success' => true,
        'cart' => $cart,
        'cart_count' => count($cart),
        'total' => number_format($total, 2),
        'session_id' => session_id()
    ];
}

// Handle different request methods
switch ($_SERVER['REQUEST_METHOD']) {
    case 'POST':
        // Get JSON input
        $input = json_decode(file_get_contents('php://input'), true);
        
        // Also check POST data for form submissions
        if (!$input) {
            $input = $_POST;
        }
        
        $game_id = isset($input['game_id']) ? $input['game_id'] : null;
        
        if (!$game_id) {
            echo json_encode([
                'success' => false,
                'message' => 'Game ID is required'
            ]);
            exit();
        }
        
        $result = addToCart($game_id);
        echo json_encode($result);
        break;
        
    case 'GET':
        // Return cart contents
        $result = getCartContents();
        echo json_encode($result);
        break;
        
    default:
        echo json_encode([
            'success' => false,
            'message' => 'Method not allowed'
        ]);
        http_response_code(405);
        break;
}
?>