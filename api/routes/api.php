<?php
require_once './controllers/UserController.php';

$request = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

if (strpos($request, "/api/users") !== false && $method == "GET") {
    $controller = new UserController();
    $controller->index();
}
?>