<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

function respond($status, $payload)
{
    http_response_code($status);
    echo json_encode($payload);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

try {
    $pdo = require __DIR__ . '/config.php';

    if ($method === 'GET' && $action === 'health') {
        $pdo->query('SELECT 1');
        respond(200, ['status' => 'ok']);
    }

    if ($method === 'GET' && $action === 'categories') {
        $statement = $pdo->query(
            'SELECT c.id, c.name, COUNT(p.id) AS product_count
             FROM categories AS c
             LEFT JOIN products AS p
               ON p.category_id = c.id AND p.is_active = 1
             WHERE c.parent_id IS NOT NULL
             GROUP BY c.id, c.name
             ORDER BY c.name'
        );

        respond(200, ['data' => $statement->fetchAll()]);
    }

    if ($method !== 'POST' || !in_array($action, ['register', 'login'], true)) {
        respond(404, ['error' => 'Unknown API action.']);
    }

    $input = json_decode(file_get_contents('php://input'), true);
    if (!is_array($input)) {
        respond(400, ['error' => 'Request body must be valid JSON.']);
    }

    if ($action === 'register') {
        $username = $input['username'] ?? null;
        $email = $input['email'] ?? null;
        $password = $input['password'] ?? null;

        if (!is_string($username) || !is_string($email) || !is_string($password)) {
            respond(400, ['error' => 'Username, email, and password are required.']);
        }

        $username = trim($username);
        $email = strtolower(trim($email));

        if (strlen($username) < 3 || strlen($username) > 80) {
            respond(400, ['error' => 'Username must be between 3 and 80 characters.']);
        }

        if (strlen($email) > 254 || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            respond(400, ['error' => 'Enter a valid email address.']);
        }

        if (strlen($password) < 8 || strlen($password) > 72) {
            respond(400, ['error' => 'Password must be between 8 and 72 bytes.']);
        }

        $statement = $pdo->prepare(
            'INSERT INTO users (username, email, password_hash)
             VALUES (:username, :email, :password_hash)'
        );

        try {
            $statement->execute([
                'username' => $username,
                'email' => $email,
                'password_hash' => password_hash($password, PASSWORD_DEFAULT),
            ]);
        } catch (PDOException $exception) {
            if ($exception->getCode() === '23000') {
                respond(409, ['error' => 'That username or email is already registered.']);
            }

            throw $exception;
        }

        respond(201, [
            'data' => [
                'id' => (int) $pdo->lastInsertId(),
                'username' => $username,
                'email' => $email,
            ],
        ]);
    }

    $identifier = $input['identifier'] ?? null;
    $password = $input['password'] ?? null;

    if (!is_string($identifier) || !is_string($password)
        || trim($identifier) === '' || $password === '') {
        respond(400, ['error' => 'Username/email and password are required.']);
    }

    $statement = $pdo->prepare(
        'SELECT id, username, email, password_hash
         FROM users
         WHERE username = :username OR email = :email
         LIMIT 1'
    );
    $statement->execute([
        'username' => trim($identifier),
        'email' => strtolower(trim($identifier)),
    ]);
    $user = $statement->fetch();

    if (!$user || !password_verify($password, $user['password_hash'])) {
        respond(401, ['error' => 'Invalid username/email or password.']);
    }

    respond(200, [
        'data' => [
            'id' => (int) $user['id'],
            'username' => $user['username'],
            'email' => $user['email'],
        ],
    ]);
} catch (PDOException $exception) {
    respond(500, [
        'error' => 'Database request failed. Check the babyshop_db connection and users table.',
    ]);
}
