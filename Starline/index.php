<?php
// Database connection
$host = 'mysql';
$db = 'starline_service_db';
$user = 'root';
$pass = 'root'; // Updated to match the MYSQL_ROOT_PASSWORD in docker-compose.yml
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed: ' . $e->getMessage()]);
    exit;
}

// Handle GET request to the root endpoint
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_SERVER['REQUEST_URI'] === '/') {
    header('Content-Type: application/json');
    echo json_encode(['message' => 'Welcome to the Starline service!']);
    exit;
}

// Handle GET request to fetch users
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_SERVER['REQUEST_URI'] === '/users') {
    try {
        $stmt = $pdo->query('SELECT * FROM users');
        $users = $stmt->fetchAll();
        header('Content-Type: application/json');
        echo json_encode($users);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch users: ' . $e->getMessage()]);
    }
    exit;
}

// Default response for unsupported routes
http_response_code(404);
echo json_encode(['error' => 'Endpoint not found']);