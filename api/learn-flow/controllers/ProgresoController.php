<?php
require_once './dao/ProgresoDao.php';
require_once './models/Progreso.php';
require_once './helpers/utils.php';

class ProgresoController {
    private $dao;

    public function __construct() {
        $this->dao = new ProgresoDao();
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
        $obj = new Progreso();
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $obj->avance = secondsToHms($obj->avance);
        $result = $this->dao->insert($obj);
        echo jsonResponse(['success' => $result], 201, 'Created');
    }

    public function update($id) {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Progreso();
        $obj->id = $id;
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $obj->avance = secondsToHms($obj->avance);
        $result = $this->dao->update($obj);
        echo jsonResponse(['success' => $result]);
    }

    public function destroy($id) {
        $result = $this->dao->delete($id);
        echo jsonResponse(['success' => $result]);
    }

    public function obtenerAvanceCursoClaseArchivo($persona_id, $curso_id, $clase_id, $archivo_id) {
        $avance = $this->dao->obtenerAvanceCursoClaseArchivo($persona_id, $curso_id, $clase_id, $archivo_id);
        if ($avance) {
            // Aquí puedes agregar lógica adicional para filtrar por clase y archivo si es necesario
            return jsonResponse($avance[0], 200, 'Ok');
        } else {
            return jsonResponse(['message' => 'Progreso no encontrado'], 404, 'Not Found');
        }
    }
}
?>
