<?php
function jsonResponse($data = [], $statusCode = 200, $statusText = 'Ok')
{
    http_response_code($statusCode);
    header('Content-Type: application/json');

    echo json_encode([
        'statusCode' => $statusCode,
        'status' => $statusText,
        'httpStatus' => $_SERVER['SERVER_PROTOCOL'] . ' ' . $statusCode . ' ' . $statusText,
        'data' => $data
    ]);
    exit;
}