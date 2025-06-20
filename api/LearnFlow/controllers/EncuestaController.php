<?php
require_once './dao/EncuestaDao.php';
require_once './models/Encuesta.php';

class EncuestaController {
    private $dao;

    public function __construct() {
        $this->dao = new EncuestaDao();
    }

    public function index() {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo jsonResponse($data);
    }

    public function show($id) {
        $stmt = $this->dao->getById($id);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $statusCode = 200;
        $statusText = 'Ok';
        if(empty($data)){
            $statusCode = 404;
            $statusText = 'Not found';
        }
        echo jsonResponse($data,$statusCode, $statusText);
    }

    public function store() {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Encuesta();
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->insert($obj);
        echo jsonResponse(['success' => $result], 201, 'Created');
    }

    public function update($id) {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Encuesta();
        $obj->id = $id;
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->update($obj);
        echo jsonResponse(['success' => $result]);
    }

    public function destroy($id) {
        $result = $this->dao->delete($id);
        echo jsonResponse(['success' => $result]);
    }
}
?>
