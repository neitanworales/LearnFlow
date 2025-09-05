<?php
require_once './dao/UserTokenDAO.php';
require_once './helpers/response.php';
require_once './controllers/AuthController.php';

class SessionController
{
    private $tokenDao;
    private $authController;

    public function __construct()
    {
        $this->tokenDao = new UserTokenDAO();
        $this->authController = new AuthController();
    }

    // POST /api/session/validate
    public function validateSession($token)
    {
        $found = $this->tokenDao->getByToken($token);

        if ($found && $found['is_active']) {
            $this->authController->generateResponse($found['user_id'], $token, $found['expires_at']);
        } else {
            echo jsonResponse(['error' => 'Sesión inválida o expirada'], 401, 'Unauthorized');
        }
    }
}

?>