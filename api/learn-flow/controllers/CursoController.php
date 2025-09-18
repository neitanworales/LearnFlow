<?php
require_once './dao/CursoDao.php';
require_once './models/Curso.php';
require_once './dao/PersonaDao.php';
require_once './dao/ClaseDao.php';
require_once './dao/ProgresoDao.php';

class CursoController {
    private $dao;
    private $personaDao;
    private $claseDao;
    private $archivoDao;
    private $progresoDao;

    public function __construct() {
        $this->dao = new CursoDao();
        $this->personaDao = new PersonaDao();
        $this->claseDao = new ClaseDao();
        $this->archivoDao = new ArchivoDao();
        $this->progresoDao = new ProgresoDao();
    }

    public function index() {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($data as &$curso) {
            $curso['autor'] = $this->personaDao->getById($curso['instructor_id']);
            $clases = $this->claseDao->getByCurso($curso['id']);
            $curso['numero_clases'] = count($clases);
            $curso['duracion_total'] = array_reduce($clases, function($carry, $clase) {
                $recursos = $this->archivoDao->getByClase($clase['id']);
                foreach ($recursos as $material) {
                    if (isset($material['duracion'])) {
                        list($hours, $minutes, $seconds) = explode(':', $material['duracion']);
                        $carry += ($hours * 3600) + ($minutes * 60) + $seconds;
                    }
                }
                return $carry;
            }, 0);
            $curso['duracion_horas'] = formatMilliseconds($curso['duracion_total'] * 1000);
        }
        echo jsonResponse($data,200, 'Ok');
    }

    public function show($id) {
        $stmt = $this->dao->getById($id);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $data['autor'] = $this->personaDao->getById($data['autor_id']);
        $data['instructor'] = $this->personaDao->getById($data['instructor_id']);
        $clases = $this->claseDao->getByCurso($id);
        foreach ($clases as &$clase) {
            $clase['recursos'] = []; // Inicializa el array de recursos
            $recursos = $this->archivoDao->getByClase($clase['id']);
            foreach ($recursos as $recurso) {
                $clase['tiempo_clase'] = array_reduce($recursos, function($carry, $item) {
                    if (isset($item['duracion'])) {
                        list($hours, $minutes, $seconds) = explode(':', $item['duracion']);
                        $carry += ($hours * 3600) + ($minutes * 60) + $seconds;
                    }
                    return $carry;
                }, 0);
                $clase['tiene_video'] = false;
                if (isset($recurso['tipo']) && $recurso['tipo'] === 'video') {
                    $clase['tiene_video'] = true;
                }
                $clase['tiene_pdf'] = false;
                if (isset($recurso['tipo']) && $recurso['tipo'] === 'pdf') {
                    $clase['tiene_pdf'] = true;
                }
                $clase['tiene_audio'] = false;
                if (isset($recurso['tipo']) && $recurso['tipo'] === 'audio') {
                    $clase['tiene_audio'] = true;
                }
            }
            $clase['tiempo_clase'] = formatMilliseconds($clase['tiempo_clase'] * 1000);
            $clase['recursos'] = $recursos;
            if(!empty($_GET['persona_id'])){
                $progresos = $this->progresoDao->obtenerAvanceCursoClase($_GET['persona_id'], $id, $clase['id']);
                $porcentaje = 0;
                foreach($progresos as $prog){
                    $porcentaje += $prog['porcentaje'] ?? 0;
                }
                $clase['avance'] = $porcentaje;
                $clase['progreso'] = $progresos;
            }
        }
        $data['clases'] = $clases;
        $data['duracion_total'] = array_reduce($clases, function($carry, $clase) {
            if (isset($clase['recursos']) && is_array($clase['recursos'])) {
                foreach ($clase['recursos'] as $material) {
                    if (isset($material['duracion'])) {
                        list($hours, $minutes, $seconds) = explode(':', $material['duracion']);
                        $carry += ($hours * 3600) + ($minutes * 60) + $seconds;
                    }
                }
            }
            return $carry;
        },  0);
        $data['duracion_horas'] = formatMilliseconds($data['duracion_total'] * 1000);
        $data['numero_clases'] = count($clases);
        $data['avance'] = 0;
        if(!empty($_GET['persona_id'])){
            $progresos = $this->progresoDao->obtenerAvanceCurso($_GET['persona_id'], $id);
            $porcentaje = 0;
            foreach($progresos as $prog){
                $porcentaje += $prog['porcentaje'] ?? 0;
            }
            $data['avance'] = ($porcentaje / $data['numero_clases']);
            $data['progreso'] = $progresos;
        }
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

function formatMilliseconds($milliseconds) {
    $seconds = floor($milliseconds / 1000);
    $minutes = floor($seconds / 60);
    $hours = floor($minutes / 60);
    $milliseconds = $milliseconds % 1000;
    $seconds = $seconds % 60;
    $minutes = $minutes % 60;

    $format = '%u:%02u:%02u.%03u';
    $time = sprintf($format, $hours, $minutes, $seconds, $milliseconds);
    return rtrim($time, '0');
}
?>
