<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'db_config.php';

// Allow requests from any origin
header("Access-Control-Allow-Origin: *"); // Be more specific
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true"); // Important for sessions
header("Content-Type: application/json");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}
    
if ($_SERVER["REQUEST_METHOD"] == "POST"){
    $name = $_POST["username"];
    $password = $_POST["password"];
    
    if (!empty($name) && !empty($password)){
        
        // Create connection
        $conn = getDbConnection();
        
        // Use prepared statements for security
        $sql = "SELECT * FROM users WHERE username = ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, 's', $name);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        
        if ($result && mysqli_num_rows($result) > 0){ 
            $user = mysqli_fetch_assoc($result);
            
            // In production, use password_verify() for hashed passwords
            if ($user['password'] == $password) {
                // Store user data in session
                $_SESSION['user_id'] = $user['user_id'];
                $_SESSION['username'] = $user['username'];
                $_SESSION['email'] = $user['email'];
                $_SESSION['logged_in'] = true;
                
                echo json_encode([
                    'success' => true, 
                    'message' => 'Login successful', 
                    'user' => [
                        'id' => $user['user_id'],
                        'username' => $user['username'],
                        'email' => $user['email'],
                    ],
                    'session_id' => session_id()
                ]);
            } else {
                echo json_encode(['success' => false, 'error' => 'Incorrect password']);
            }
        } else {
            echo json_encode(['success' => false, 'error' => 'Username not found.']);
        }
        mysqli_close($conn);
    } else {
        echo json_encode(['success' => false, 'error' => 'All fields are required.']);
    }
} else {
    echo json_encode(["success" => false, 'error' => 'Invalid request method.']);
}
?>