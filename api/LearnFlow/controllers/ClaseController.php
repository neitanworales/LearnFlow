<?php
require_once './dao/ClaseDao.php';
require_once './helpers/response.php';
require_once './dao/ArchivoDao.php';

class ClaseController {
    private $claseDao;
    private $archivoDao;
    private $cursoDao;

    public function __construct() {
        $this->claseDao = new ClaseDao();
        $this->archivoDao = new ArchivoDao();
        $this->cursoDao = new CursoDao(); 
    }

    public function index() {
        $data = $this->claseDao->getAll();
        echo jsonResponse($data, 200, 'Ok');
    }

    public function show($id) {
        $data = $this->claseDao->getById($id);
        $data['recursos'] = $this->archivoDao->getByClase($id);
        $data['curso_titulo'] = $this->cursoDao->getCursoTituloByClaseId($id);
        echo jsonResponse($data, 200, 'Ok');
    }

    public function byCurso($curso_id) {
        $data = $this->claseDao->getByCurso($curso_id);
        echo jsonResponse($data, 200, 'Ok');
    }

    public function store($input) {
        $id = $this->claseDao->create(
            $input['curso_id'],
            $input['titulo'],
            $input['descripcion'],
            $input['orden']
        );
        echo jsonResponse(['status' => 'created', 'id' => $id],201, 'Created');
    }

    public function update($id, $input) {
        $ok = $this->claseDao->update(
            $id,
            $input['curso_id'],
            $input['titulo'],
            $input['descripcion'],
            $input['orden']
        );
        echo jsonResponse(['status' => $ok ? 'updated' : 'error'], 200, $ok ? 'Updated' : 'Error');
    }

    public function destroy($id) {
        $ok = $this->claseDao->delete($id);
        echo jsonResponse(['status' => $ok ? 'deleted' : 'error'], 200, $ok ? 'Deleted' : 'Error');
    }
}
?>
