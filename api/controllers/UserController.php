<?php
require_once './models/User.php';

class UserController {
    private $userDao;
    static $_instance;

    public function __construct() {
        require '../dao/UserDao.php';
        $this->userDao = UserDao::getInstance();
    }

    public static function getInstance()
    {
        if (!(self::$_instance instanceof self)) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    public function index() {
        $stmt = $this->userDao->getAll();
        $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($users);
    }
}
?>