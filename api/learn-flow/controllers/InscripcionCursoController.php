<?php
require_once './dao/InscripcionCursoDao.php';
require_once './models/InscripcionCurso.php';
require_once './dao/PersonaDao.php';
require_once './dao/ClaseDao.php';
require_once './dao/ProgresoDao.php';

class InscripcionCursoController
{
    private $dao;
    private $personaDao;
    private $claseDao;
    private $archivoDao;
    private $progresoDao;

    public function __construct()
    {
        $this->dao = new InscripcionCursoDao();
        $this->personaDao = new PersonaDao();
        $this->claseDao = new ClaseDao();
        $this->archivoDao = new ArchivoDao();
        $this->progresoDao = new ProgresoDao();
    }

    public function index()
    {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo jsonResponse($data);
    }

    public function show($id)
    {
        $stmt = $this->dao->getById($id);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $statusCode = 200;
        $statusText = 'Ok';
        if (empty($data)) {
            $statusCode = 404;
            $statusText = 'Not found';
        }
        echo jsonResponse($data, $statusCode, $statusText);
    }

    public function store()
    {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new InscripcionCurso();
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->insert($obj);
        echo jsonResponse(['success' => $result], 201, 'Created');
    }

    public function update($id)
    {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new InscripcionCurso();
        $obj->id = $id;
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->update($obj);
        echo jsonResponse(['success' => $result]);
    }

    public function destroy($id)
    {
        $result = $this->dao->delete($id);
        echo jsonResponse(['success' => $result]);
    }

    // POST /inscripciones
    public function inscribir()
    {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['persona_id'], $data['curso_id'], $data['costo_id'])) {
            return jsonResponse(['message' => 'Faltan datos obligatorios'], 400, 'Bad Request');
        }

        if ($this->dao->estaInscrita($data['persona_id'], $data['curso_id'])) {
            return jsonResponse(['message' => 'La persona ya está inscrita a este curso'], 409, 'Conflict');
        }

        $resultado = $this->dao->inscribirPersonaACurso(
            $data['persona_id'],
            $data['curso_id'],
            $data['costo_id'],
            $data['estado'] ?? 'inscrito'
        );

        if ($resultado) {
            return jsonResponse(['message' => 'Inscripción registrada correctamente']);
        } else {
            return jsonResponse(['message' => 'Error al registrar inscripción'], 500, 'Internal Server Error');
        }
    }

    // GET /inscripciones/persona/{id}
    public function obtenerPorPersona($personaId)
    {
        $result = $this->dao->obtenerCursosDePersona($personaId);
        foreach ($result as &$curso) {
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
            $curso['avance'] = $this->progresoDao->obtenerAvanceCurso($personaId, $curso['id']);
        }
        return jsonResponse($result, 200, 'Ok');
    }

    // GET /inscripciones/curso/{id}
    public function obtenerPorCurso($cursoId)
    {
        $result = $this->dao->obtenerPersonasDelCurso($cursoId);
        return jsonResponse($result, 200, 'Ok');
    }

    // GET /inscripciones
    public function obtenerTodas()
    {
        $result = $this->dao->obtenerTodasLasInscripciones();
        return jsonResponse($result, 200, 'Ok');
    }

    // DELETE /inscripciones
    public function cancelar()
    {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['persona_id'], $data['curso_id'])) {
            return jsonResponse(['message' => 'persona_id y curso_id requeridos'], 400, 'Bad Request');
        }

        $resultado = $this->dao->cancelarInscripcion($data['persona_id'], $data['curso_id']);

        if ($resultado) {
            return jsonResponse(['message' => 'Inscripción cancelada']);
        } else {
            return jsonResponse(['message' => 'Error al cancelar inscripción'], 500, 'Internal Server Error');
        }
    }

    // PUT /inscripciones/estado
    public function actualizarEstado()
    {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['persona_id'], $data['curso_id'], $data['estado'])) {
            return jsonResponse(['message' => 'persona_id, curso_id y estado requeridos'], 400, 'Bad Request');
        }

        $resultado = $this->dao->actualizarEstadoInscripcion($data['persona_id'], $data['curso_id'], $data['estado']);

        if ($resultado) {
            return jsonResponse(['message' => 'Estado actualizado']);
        } else {
            return jsonResponse(['message' => 'Error al actualizar estado'], 500, 'Internal Server Error');
        }
    }

    // PUT /inscripciones/costo
    public function actualizarCosto()
    {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['persona_id'], $data['curso_id'], $data['costo_id'])) {
            return jsonResponse(['message' => 'persona_id, curso_id y costo_id requeridos'], 400, 'Bad Request');
        }

        $resultado = $this->dao->actualizarCostoInscripcion($data['persona_id'], $data['curso_id'], $data['costo_id']);

        if ($resultado) {
            return jsonResponse(['message' => 'Costo actualizado']);
        } else {
            return jsonResponse(['message' => 'Error al actualizar costo'], 500, 'Internal Server Error');
        }
    }

}
?>