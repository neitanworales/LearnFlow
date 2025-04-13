<?php
require_once './dao/NotificacionDao.php';
require_once './models/Notificacion.php';

class NotificacionController {
    private $dao;

    public function __construct() {
        $this->dao = new NotificacionDao();
    }

    public function index() {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($data);
    }

    public function show($id) {
        $stmt = $this->dao->getById($id);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        echo json_encode($data);
    }

    public function store() {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Notificacion();
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->insert($obj);
        echo json_encode(['success' => $result]);
    }

    public function update($id) {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Notificacion();
        $obj->id = $id;
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->update($obj);
        echo json_encode(['success' => $result]);
    }

    public function destroy($id) {
        $result = $this->dao->delete($id);
        echo json_encode(['success' => $result]);
    }
}
?>
