<?php
// Incluimos todos los controladores
require_once './helpers/response.php';
require_once './controllers/AuthController.php';
require_once './controllers/SessionController.php';
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
require_once './controllers/ClaseController.php';

// Detectar URI y método HTTP
$scriptName = $_SERVER['SCRIPT_NAME']; // e.g. /LearnFlow/index.php
$scriptDir = str_replace('/index.php', '', $scriptName);
$uri = str_replace($scriptDir, '', $_SERVER['REQUEST_URI']);
$uri = parse_url($uri, PHP_URL_PATH);
$uri = '/' . ltrim($uri, '/');
$method = $_SERVER['REQUEST_METHOD'];

// Función para definir rutas
function route($pattern, $callback)
{
    global $uri;
    $regex = "@^" . preg_replace('/\\\{[a-zA-Z_]+\\\}/', '([0-9]+)', preg_quote($pattern)) . "$@";
    if (preg_match($regex, $uri, $params)) {
        array_shift($params);
        call_user_func_array($callback, $params);
        exit;
    }
}

// Función para automatizar rutas CRUD
function resourceRoutes($resource, $controllerName)
{
    global $method;
    $controller = new $controllerName();

    route("/$resource", function () use ($method, $controller, $resource) {

        if ($resource === 'login' || $resource === 'logout' || $resource === 'session') {
            if ($method === 'POST') {
                $data = json_decode(file_get_contents("php://input"), true);
                
                if ($resource === 'login') {
                    $controller = new AuthController();
                    if (!isset($data['email']) || !isset($data['password'])) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'Email y contraseña son requeridos'], 400, 'Bad Request');
                        exit;
                    }
                    if (empty($data['email']) || empty($data['password'])) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'Email y contraseña no pueden estar vacíos'], 400, 'Bad Request');
                        exit;
                    }
                    if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'Email inválido'], 400, 'Bad Request');
                        exit;
                    }
                    if (strlen($data['password']) < 6) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'La contraseña debe tener al menos 6 caracteres'], 400, 'Bad Request');
                        exit;
                    }

                    $controller->login($data['email'], $data['password']);
                } else if ($resource === 'logout') {
                    $controller = new AuthController();
                    if (!isset($data['token'])) {
                        $data['token'] = null; // Aseguramos que el token sea null si no se proporciona
                    }
                    if (empty($data['token'])) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'Token es requerido'], 400, 'Bad Request');
                        exit;
                    }

                    $controller->logout($data['token']);
                }   else if ($resource === 'session') {
                    $controller = new SessionController();
                    if (!isset($data['token'])) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'Token es requerido'], 400, 'Bad Request');
                        exit;
                    }
                    if (empty($data['token'])) {
                        http_response_code(400);
                        echo jsonResponse(['error' => 'Token no puede estar vacío'], 400, 'Bad Request');
                        exit;
                    }
                    $controller->validateSession($data['token']);
                }
            } else {
                http_response_code(405);
                echo jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
                exit;
            }
        } else if ($resource === 'session') {
            if ($method === 'POST') {
                $data = json_decode(file_get_contents("php://input"), true);
                if (!isset($data['token'])) {
                    http_response_code(400);
                    echo jsonResponse(['error' => 'Token es requerido'], 400, 'Bad Request');
                    exit;
                }
                $controller = new SessionController();
                if (empty($data['token'])) {
                    http_response_code(400);
                    echo jsonResponse(['error' => 'Token no puede estar vacío'], 400, 'Bad Request');
                    exit;
                }
                $controller->validateSession($data['token']);
            } else {
                http_response_code(405);
                echo jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
                exit;
            }
        } else {

            if ($method === 'GET')
                $controller->index();
            if ($method === 'POST')
                $controller->store();
        }
    });


    route("/$resource/{id}", function ($id) use ($method, $controller) {
        if ($method === 'GET')
            $controller->show($id);
        if ($method === 'PUT')
            $controller->update($id);
        if ($method === 'DELETE')
            $controller->destroy($id);
    });
}

$inscripcionController = new InscripcionCursoController();

// POST /inscripciones
route('/inscripciones', function () use ($method, $inscripcionController) {
    if ($method === 'POST') {
        $inscripcionController->inscribir();
    } elseif ($method === 'GET') {
        $inscripcionController->obtenerTodas();
    } elseif ($method === 'DELETE') {
        $inscripcionController->cancelar();
    } else {
        jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
    }
});

// GET /inscripciones/persona/{id}
route('/inscripciones/persona/{id}', function ($id) use ($method, $inscripcionController) {
    if ($method === 'GET') {
        $inscripcionController->obtenerPorPersona($id);
    } else {
        jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
    }
});

// GET /inscripciones/curso/{id}
route('/inscripciones/curso/{id}', function ($id) use ($method, $inscripcionController) {
    if ($method === 'GET') {
        $inscripcionController->obtenerPorCurso($id);
    } else {
        jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
    }
});

// PUT /inscripciones/estado
route('/inscripciones/estado', function () use ($method, $inscripcionController) {
    if ($method === 'PUT') {
        $inscripcionController->actualizarEstado();
    } else {
        jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
    }
});

// PUT /inscripciones/costo
route('/inscripciones/costo', function () use ($method, $inscripcionController) {
    if ($method === 'PUT') {
        $inscripcionController->actualizarCosto();
    } else {
        jsonResponse(['error' => 'Método no permitido'], 405, 'Method Not Allowed');
    }
});


// Declarar las rutas para cada recurso
resourceRoutes('usuarios', 'UsuarioController');
resourceRoutes('personas', 'PersonaController');
resourceRoutes('roles', 'RolController');
resourceRoutes('organizaciones', 'OrganizacionController');
resourceRoutes('cursos', 'CursoController');
resourceRoutes('clases', 'ClaseController');
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
resourceRoutes('login', 'AuthController');
resourceRoutes('logout', 'AuthController');
resourceRoutes('session', 'SessionController');

// Ruta por defecto
echo jsonResponse(['error' => 'Ruta no encontrada'], 404, 'Not Found');
