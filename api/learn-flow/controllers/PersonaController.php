<?php
require_once './dao/PersonaDao.php';
require_once './models/Persona.php';
require_once './helpers/response.php';
require_once './dao/InscripcionCursoDao.php';
require_once './dao/CursoDao.php';
require_once './dao/ProgresoDao.php';

class PersonaController {
    private $dao;
    private $inscripcionCursoDao;
    private $cursoDao;
    private $progresoDao;

    public function __construct() {
        $this->dao = new PersonaDao();
        $this->inscripcionCursoDao = new InscripcionCursoDao();
        $this->cursoDao = new CursoDao();
        $this->progresoDao = new ProgresoDao();
    }

    public function index() {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo jsonResponse($data);
    }

    public function show($id) {
        $personas = $this->dao->getById($id);
        foreach ($personas as $persona) {
            $cursosInscritos = $this->inscripcionCursoDao->obtenerCursosDePersona($persona['id']);
            $cursos = [];
            foreach ($cursosInscritos as $cursoInscrito) {
                $cursoStmt = $this->cursoDao->getById($cursoInscrito['curso_id']);
                $curso = $cursoStmt->fetch(PDO::FETCH_ASSOC);
                if ($curso) {
                    $curso['avance'] = $this->progresoDao->obtenerAvanceCurso($persona['id'], $cursoInscrito['curso_id']);
                    array_push($cursos, $curso);
                }
            }
            $persona['cursos'] = $cursos;
        }
        $personas = $persona;
        $data = $personas->fetch(PDO::FETCH_ASSOC);
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
        $obj = new Persona();
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
        $obj = new Persona();
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
