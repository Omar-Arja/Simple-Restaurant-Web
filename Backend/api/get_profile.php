<?php
require_once '../db/connection.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get user_id from query parameters
    $userId = $_GET['user_id'] ?? '';

    // Validate user_id
    if (empty($userId) || !filter_var($userId, FILTER_VALIDATE_INT)) {
        echo json_encode(['success' => false, 'message' => 'Invalid or missing user ID.']);
        exit;
    }

    try {
        // Fetch user data from the database
        $stmt = $pdo->prepare('SELECT id, name, email, phone, address, profile_image, created_at FROM users WHERE id = ?');
        $stmt->execute([$userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            // Add image URL to the response
            $user['image_url'] = 'http://localhost:8000/images/' . ($user['profile_image'] ?? 'default.png');
            echo json_encode(['success' => true, 'user' => $user]);
        } else {
            echo json_encode(['success' => false, 'message' => 'User not found.']);
        }
    } catch (PDOException $e) {
        // Handle database errors
        echo json_encode(['success' => false, 'message' => 'An error occurred while retrieving the user.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
