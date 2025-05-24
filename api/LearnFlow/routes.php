<?php
// Incluimos todos los controladores
require_once './controllers/UsuarioController.php';
require_once './controllers/PersonaController.php';
require_once './controllers/RolController.php';
require_once './controllers/OrganizacionController.php';
require_once './controllers/CursoController.php';
require_once './controllers/CostoCursoController.php';
require_once './controllers/InscripcionCursoController.php';
require_once './controllers/EventoController.php';
require_once './controllers/PaqueteEventoController.php';
require_once './controllers/InscripcionEventoController.php';
require_once './controllers/EvaluacionController.php';
require_once './controllers/RespuestaEvaluacionController.php';
require_once './controllers/CertificadoController.php';
require_once './controllers/ArchivoController.php';
require_once './controllers/ForoController.php';
require_once './controllers/MensajeForoController.php';
require_once './controllers/AgendaController.php';
require_once './controllers/PagoController.php';
require_once './controllers/NotificacionController.php';
require_once './controllers/EncuestaController.php';
require_once './controllers/RespuestaEncuestaController.php';
require_once './controllers/ProgresoController.php';

// Detectar URI y método HTTP
$scriptName = $_SERVER['SCRIPT_NAME']; // e.g. /LearnFlow/index.php
$scriptDir = str_replace('/index.php', '', $scriptName);
$uri = str_replace($scriptDir, '', $_SERVER['REQUEST_URI']);
$uri = parse_url($uri, PHP_URL_PATH);
$uri = '/' . ltrim($uri, '/');
$method = $_SERVER['REQUEST_METHOD'];

// Función para definir rutas
function route($pattern, $callback) {
    global $uri;
    $regex = "@^" . preg_replace('/\\\{[a-zA-Z_]+\\\}/', '([0-9]+)', preg_quote($pattern)) . "$@";
    if (preg_match($regex, $uri, $params)) {
        array_shift($params);
        call_user_func_array($callback, $params);
        exit;
    }
}

// Función para automatizar rutas CRUD
function resourceRoutes($resource, $controllerName) {
    global $method;
    $controller = new $controllerName();

    route("/api/$resource", function() use ($method, $controller) {
        if ($method === 'GET') $controller->index();
        if ($method === 'POST') $controller->store();
    });

    route("/api/$resource/{id}", function($id) use ($method, $controller) {
        if ($method === 'GET') $controller->show($id);
        if ($method === 'PUT') $controller->update($id);
        if ($method === 'DELETE') $controller->destroy($id);
    });
}

// Declarar las rutas para cada recurso
resourceRoutes('usuarios', 'UsuarioController');
resourceRoutes('personas', 'PersonaController');
resourceRoutes('roles', 'RolController');
resourceRoutes('organizaciones', 'OrganizacionController');
resourceRoutes('cursos', 'CursoController');
resourceRoutes('costos-curso', 'CostoCursoController');
resourceRoutes('inscripciones-curso', 'InscripcionCursoController');
resourceRoutes('eventos', 'EventoController');
resourceRoutes('paquetes-evento', 'PaqueteEventoController');
resourceRoutes('inscripciones-evento', 'InscripcionEventoController');
resourceRoutes('evaluaciones', 'EvaluacionController');
resourceRoutes('respuestas-evaluacion', 'RespuestaEvaluacionController');
resourceRoutes('certificados', 'CertificadoController');
resourceRoutes('archivos', 'ArchivoController');
resourceRoutes('foros', 'ForoController');
resourceRoutes('mensajes-foro', 'MensajeForoController');
resourceRoutes('agenda', 'AgendaController');
resourceRoutes('pagos', 'PagoController');
resourceRoutes('notificaciones', 'NotificacionController');
resourceRoutes('encuestas', 'EncuestaController');
resourceRoutes('respuestas-encuesta', 'RespuestaEncuestaController');
resourceRoutes('progreso', 'ProgresoController');

// Ruta por defecto
http_response_code(404);
echo json_encode(['error' => 'Ruta no encontrada']);
