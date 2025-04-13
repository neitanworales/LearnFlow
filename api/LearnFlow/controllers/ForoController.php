<?php
require_once './dao/ForoDao.php';
require_once './models/Foro.php';

class ForoController {
    private $dao;

    public function __construct() {
        $this->dao = new ForoDao();
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
        $obj = new Foro();
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
        $obj = new Foro();
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
