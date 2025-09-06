<?php
// /api/learn-flow/proxy-image.php
ini_set('display_errors', 0);

$id = $_GET['id'] ?? '';
if (!$id || !preg_match('/^[a-zA-Z0-9_-]{20,}$/', $id)) {
  http_response_code(400);
  exit('missing or invalid id');
}

// Usa "view" o "download". Prueba ambos si uno falla.
$driveUrl = "https://drive.google.com/uc?export=view&id=" . urlencode($id);
// $driveUrl = "https://drive.google.com/uc?export=download&id=" . urlencode($id);

$ch = curl_init($driveUrl);
curl_setopt_array($ch, [
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_USERAGENT => 'Mozilla/5.0',
  CURLOPT_CONNECTTIMEOUT => 10,
  CURLOPT_TIMEOUT => 20,
  CURLOPT_SSL_VERIFYPEER => true,
  CURLOPT_HTTPHEADER => [
    'Accept: image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
  ],
]);
$data = curl_exec($ch);
$http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$ct   = curl_getinfo($ch, CURLINFO_CONTENT_TYPE) ?: '';
curl_close($ch);

if ($http !== 200 || !$data) {
  // Segundo intento: usar thumbnail (suele saltarse bloqueos)
  $thumbUrl = "https://drive.google.com/thumbnail?id=" . urlencode($id) . "&sz=w2000";
  $ch = curl_init($thumbUrl);
  curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_USERAGENT => 'Mozilla/5.0',
    CURLOPT_CONNECTTIMEOUT => 10,
    CURLOPT_TIMEOUT => 20,
    CURLOPT_SSL_VERIFYPEER => true,
  ]);
  $data = curl_exec($ch);
  $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $ct   = curl_getinfo($ch, CURLINFO_CONTENT_TYPE) ?: '';
  curl_close($ch);
}

if ($http !== 200 || !$data) {
  http_response_code(502);
  exit('upstream 403/502');
}

// Forzar tipo imagen si Drive no lo manda claro
if (stripos($ct, 'image/') !== 0) {
  $ct = 'image/jpeg';
}

header('Content-Type: ' . $ct);
// Cachea fuerte para no pegarle a Drive cada vez
header('Cache-Control: public, max-age=31536000, immutable');
echo $data;
?>