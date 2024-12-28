<?php
require_once '../db/connection.php';

header('Access-Control-Allow-Origin: *'); // Allow requests from any origin
header('Access-Control-Allow-Methods: POST, GET, OPTIONS'); // Allow specific methods
header('Access-Control-Allow-Headers: Content-Type, Authorization'); // Allow specific headers
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        // Fetch all dishes from the database
        $stmt = $pdo->query('SELECT dish_id, name, description, price, image, chef_id FROM dishes');
        $dishes = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Add image URL for each dish
        foreach ($dishes as &$dish) {
            $dish['image_url'] = 'http://localhost:8000/images/' . ($dish['image'] ?? 'default_dish.png');
        }

        // Return success response
        echo json_encode(['success' => true, 'dishes' => $dishes]);
    } catch (PDOException $e) {
        // Return error response in case of a database issue
        echo json_encode(['success' => false, 'message' => 'Failed to fetch dishes: ' . $e->getMessage()]);
    }
} else {
    // Return error for invalid request method
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
