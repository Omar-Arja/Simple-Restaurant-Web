<?php
require_once '../db/connection.php';

header('Access-Control-Allow-Origin: *'); // Allow requests from any origin
header('Access-Control-Allow-Methods: POST, GET, OPTIONS'); // Allow specific methods
header('Access-Control-Allow-Headers: Content-Type, Authorization'); // Allow specific headers
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userId = $_POST['user_id'] ?? null;
    $name = $_POST['name'] ?? null;
    $phone = $_POST['phone'] ?? null;
    $address = $_POST['address'] ?? null;
    $password = $_POST['password'] ?? null;
    $email = $_POST['email'] ?? null;
    $profileImage = $_FILES['profile_image'] ?? null;

    // Validate user ID
    if (empty($userId) || !filter_var($userId, FILTER_VALIDATE_INT)) {
        echo json_encode(['success' => false, 'message' => 'Invalid or missing user ID.']);
        exit;
    }

    // Validate email
    if (!empty($email)) {
        // Check if the email is a valid format
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo json_encode(['success' => false, 'message' => 'Invalid email address.']);
            exit;
        }

        // Check if the email is already taken by another user
        $stmt = $pdo->prepare('SELECT id FROM users WHERE email = ? AND id != ?');
        $stmt->execute([$email, $userId]);
        if ($stmt->fetch()) {
            echo json_encode(['success' => false, 'message' => 'Email is already taken.']);
            exit;
        }
    }

    try {
        $fields = [];
        $params = [];

        // Dynamically add fields to update
        if (!empty($name)) {
            $fields[] = 'name = ?';
            $params[] = $name;
        }

        if (!empty($phone)) {
            $fields[] = 'phone = ?';
            $params[] = $phone;
        }

        if (!empty($address)) {
            $fields[] = 'address = ?';
            $params[] = $address;
        }

        if (!empty($password)) {
            $fields[] = 'password = ?';
            $params[] = password_hash($password, PASSWORD_BCRYPT); // Hash the password
        }

        if (!empty($email)) {
            $fields[] = 'email = ?';
            $params[] = $email;
        }

        if ($profileImage && !empty($profileImage['name'])) {
            // Validate and upload the image
            $allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
            if (!in_array($profileImage['type'], $allowedTypes)) {
                echo json_encode(['success' => false, 'message' => 'Invalid image type. Only JPEG, PNG, GIF, and WEBP are allowed.']);
                exit;
            }

            if ($profileImage['size'] > 5 * 1024 * 1024) { // 5 MB max size
                echo json_encode(['success' => false, 'message' => 'File size exceeds 5MB.']);
                exit;
            }

            $imageName = uniqid() . '_' . basename($profileImage['name']);
            $targetPath = "../images/$imageName";

            if (!move_uploaded_file($profileImage['tmp_name'], $targetPath)) {
                echo json_encode(['success' => false, 'message' => 'Failed to upload image.']);
                exit;
            }

            $fields[] = 'profile_image = ?';
            $params[] = $imageName;
        }

        // Ensure there are fields to update
        if (empty($fields)) {
            echo json_encode(['success' => false, 'message' => 'No fields to update.']);
            exit;
        }

        // Build the query
        $query = 'UPDATE users SET ' . implode(', ', $fields) . ' WHERE id = ?';
        $params[] = $userId;

        // Execute the query
        $stmt = $pdo->prepare($query);
        $stmt->execute($params);

        // Fetch the updated user data
        $stmt = $pdo->prepare('SELECT id, name, phone, address, email, profile_image FROM users WHERE id = ?');
        $stmt->execute([$userId]);
        $updatedUser = $stmt->fetch(PDO::FETCH_ASSOC);

        // Add image URL to the response
        if ($updatedUser) {
            $updatedUser['image_url'] = 'http://localhost:8000/images/' . ($updatedUser['profile_image'] ?? 'default.png');
        }

        echo json_encode(['success' => true, 'message' => 'Profile updated successfully.', 'data' => $updatedUser]);
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
