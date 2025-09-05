<?php
require_once './dao/CursoDao.php';
require_once './models/Curso.php';
require_once './dao/PersonaDao.php';
require_once './dao/ClaseDao.php';

class CursoController {
    private $dao;
    private $personaDao;
    private $claseDao;

    public function __construct() {
        $this->dao = new CursoDao();
        $this->personaDao = new PersonaDao();
        $this->claseDao = new ClaseDao();
    }

    public function index() {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($data as &$curso) {
            $curso['autor'] = $this->personaDao->getById($curso['instructor_id']);
        }
        echo jsonResponse($data,200, 'Ok');
    }

    public function show($id) {
        $stmt = $this->dao->getById($id);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $data['autor'] = $this->personaDao->getById($data['autor_id']);
        $data['instructor'] = $this->personaDao->getById($data['instructor_id']);
        $data['clases'] = $this->claseDao->getByCurso($id);
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
        $obj = new Curso();
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
        $obj = new Curso();
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
