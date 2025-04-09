<?php 

class UserDao{
    private $table = "user";
    public $bd;
    static $_instance;

    private function __construct()
    {
        require '../config/Db.class.php';
        $this->bd = Db::getInstance();
    }

    /*Funci?n encargada de crear, si es necesario, el objeto. Esta es la funci?n que debemos llamar desde fuera de la clase para instanciar el objeto, y as?, poder utilizar sus m?todos*/
    public static function getInstance()
    {
        if (!(self::$_instance instanceof self)) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    public function getAll(){
        $que = "SELECT * FROM " . $this->table . " ORDER BY id DESC";
        return $this->bd->execute($que);
    }
}