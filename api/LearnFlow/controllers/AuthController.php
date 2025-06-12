<?php
require_once './models/Usuario.php';
require_once './dao/UsuarioDao.php';
require_once './dao/TokenDao.php';
require_once './helpers/response.php';

class AuthController
{
    private $conn;
    private $usuarioDao;
    private $tokenDao;

    public function __construct()
    {
        $this->usuarioDao = new UsuarioDao();
        $this->tokenDao = new UserTokenDAO();
    }

    // POST /api/login
    public function login($email, $password)
    {
        $user = $this->usuarioDao->getByEmail($email);
        if (!$user) {
            echo jsonResponse(['error' => 'Usuario no encontrado'], 404, 'Not Found');
            return;
        }
        $usuario = $user->fetch(PDO::FETCH_ASSOC); // Asegurarse de que es un array asociativo
        if (!$usuario) {
            echo jsonResponse(['error' => 'Usuario no encontrado'], 404, 'Not Found');
            return;
        }
        if ($user && ($password === $usuario['contrasena'])) {
            $token = bin2hex(random_bytes(32)); // Genera token único
            $expires = date('Y-m-d H:i:s', strtotime('+1 day'));
            $this->tokenDao->create($usuario['id'], $token, $expires);
            echo jsonResponse([
                'status' => 'ok',
                'token' => $token,
                'user_id' => $usuario['id'],
                'expires_at' => $expires
            ], 200, 'Ok');
        } else {
            echo jsonResponse(['error' => 'Credenciales inválidas'], 401, 'Unauthorized');
        }
    }

    // POST /api/logout
    public function logout($token)
    {
        $found = $this->tokenDao->getByToken($token);

        if ($found && $found['is_active']) {
            $this->tokenDao->revokeToken($token);
            echo jsonResponse(['status' => 'logged_out'], 200, 'Ok');
        } else {
            echo jsonResponse(['error' => 'Token inválido o ya cerrado'], 400, 'Bad Request');
        }
    }
}
?>