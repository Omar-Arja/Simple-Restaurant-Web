<?php
require_once '../db/connection.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $phone = $_POST['phone'] ?? '';
    $address = $_POST['address'] ?? '';
    $password = $_POST['password'] ?? '';
    $profileImage = $_FILES['profile_image'] ?? null;

    // Validate required fields
    if (empty($name) || empty($email) || empty($phone) || empty($address) || empty($password)) {
        echo json_encode(['success' => false, 'message' => 'All fields are required.']);
        exit;
    }

    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(['success' => false, 'message' => 'Invalid email format.']);
        exit;
    }

    // Check if email already exists
    $stmt = $pdo->prepare('SELECT id FROM users WHERE email = ?');
    $stmt->execute([$email]);
    if ($stmt->fetch()) {
        echo json_encode(['success' => false, 'message' => 'Email already exists.']);
        exit;
    }

    // Hash the password for security
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    // Handle profile image upload
    $imageName = null;
    if ($profileImage && !empty($profileImage['name'])) {
        // Validate image file
        $allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
        if (!in_array($profileImage['type'], $allowedTypes)) {
            echo json_encode(['success' => false, 'message' => 'Invalid image type. Only JPEG, PNG, GIF, and WEBP are allowed.']);
            exit;
        }

        if ($profileImage['size'] > 5 * 1024 * 1024) { // 5 MB max size
            echo json_encode(['success' => false, 'message' => 'File size exceeds 5MB.']);
            exit;
        }

        // Generate unique file name and save to images directory
        $imageName = uniqid() . '_' . basename($profileImage['name']);
        $targetPath = "../images/$imageName";

        if (!move_uploaded_file($profileImage['tmp_name'], $targetPath)) {
            echo json_encode(['success' => false, 'message' => 'Failed to upload profile image.']);
            exit;
        }
    }

    // Insert user into the database
    try {
        $stmt = $pdo->prepare('INSERT INTO users (name, email, phone, address, password, profile_image) VALUES (?, ?, ?, ?, ?, ?)');
        $stmt->execute([$name, $email, $phone, $address, $hashedPassword, $imageName]);

        $userId = $pdo->lastInsertId();

        // Retrieve the newly created user
        $stmt = $pdo->prepare('SELECT id, name, email, phone, address, profile_image FROM users WHERE id = ?');
        $stmt->execute([$userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        // Add the image URL
        $user['image_url'] = 'http://localhost:8000/images/' . ($user['profile_image'] ?? 'default.png');

        echo json_encode(['success' => true, 'message' => 'User registered successfully', 'user' => $user]);
    } catch (PDOException $e) {
        // Handle any database errors
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
