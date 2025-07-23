<?php
require_once './config/Db.class.php';

class InscripcionCursoDao {
    private $table = 'inscripciones_curso';
    public $bd;

    public function __construct() {
        $this->bd = Db::getInstance();
    }

    public function getAll() {
        $query = "SELECT * FROM {$this->table}";
        return $this->bd->execute($query);
    }

    public function getById($id) {
        $query = "SELECT * FROM {$this->table} WHERE id = :id";
        return $this->bd->execute($query, [':id' => $id]);
    }

    public function insert($obj) {
        $props = get_object_vars($obj);
        unset($props['id']);
        $columns = implode(', ', array_keys($props));
        $placeholders = ':' . implode(', :', array_keys($props));

        $query = "INSERT INTO {$this->table} ($columns) VALUES ($placeholders)";
        $params = [];
        foreach ($props as $key => $value) {
            $params[":$key"] = $value;
        }
        return $this->bd->execute($query, $params);
    }

    public function update($obj) {
        $props = get_object_vars($obj);
        $id = $props['id'];
        unset($props['id']);

        $set = implode(', ', array_map(fn($key) => "$key = :$key", array_keys($props)));

        $query = "UPDATE {$this->table} SET $set WHERE id = :id";
        $params = [':id' => $id];
        foreach ($props as $key => $value) {
            $params[":$key"] = $value;
        }
        return $this->bd->execute($query, $params);
    }

    public function delete($id) {
        $query = "DELETE FROM {$this->table} WHERE id = :id";
        return $this->bd->execute($query, [':id' => $id]);
    }

    // Crear una inscripción
    public function inscribirPersonaACurso($personaId, $cursoId, $costoId, $estado = 'inscrito') {
        $query = "INSERT INTO {$this->table} (persona_id, curso_id, costo_id, fecha_inscripcion, estado) VALUES (:persona_id, :curso_id, :costo_id, NOW(), :estado)";
        return $this->bd->execute($query, [
            ':persona_id'=>$personaId, 
            ':curso_id'=>$cursoId, 
            ':costo_id'=>$costoId, 
            ':estado'=>$estado]);
    }

    // Obtener todos los cursos en los que está inscrita una persona
    public function obtenerCursosDePersona($personaId) {
        $query = "SELECT c.*, ic.estado, ic.fecha_inscripcion, ic.costo_id
            FROM cursos c
            JOIN {$this->table} ic ON c.id = ic.curso_id
            WHERE ic.persona_id = :persona_id";
        return $this->bd->execute($query, [':persona_id'=>$personaId])->fetchAll(PDO::FETCH_ASSOC);
    }

    // Obtener todas las personas inscritas en un curso
    public function obtenerPersonasDelCurso($cursoId) {
        $query = "SELECT p.*, ic.estado, ic.fecha_inscripcion, ic.costo_id
            FROM persona p
            JOIN {$this->table} ic ON p.id = ic.persona_id
            WHERE ic.curso_id = :curso_id";
        return $this->bd->execute($query, [':curso_id'=>$cursoId])->fetchAll(PDO::FETCH_ASSOC);
    }

    // Cancelar inscripción
    public function cancelarInscripcion($personaId, $cursoId) {
        $query = "DELETE FROM {$this->table} WHERE persona_id = :persona_id AND curso_id = :curso_id";
        return $this->bd->execute($query, [
            ':persona_id'=>$personaId, 
            ':curso_id'=>$cursoId]);
    }

    // Actualizar estado
    public function actualizarEstadoInscripcion($personaId, $cursoId, $nuevoEstado) {
        $query = "
            UPDATE {$this->table} SET estado = :estado WHERE persona_id = :persona_id AND curso_id = :curso_id";
        return $this->bd->execute($query, [
            ':estado'=>$nuevoEstado, 
            ':persona_id'=> $personaId, 
            ':curso_id'=>$cursoId]);
    }

    // Actualizar costo asociado
    public function actualizarCostoInscripcion($personaId, $cursoId, $nuevoCostoId) {
        $query = "UPDATE {$this->table} SET costo_id = :costo_id WHERE persona_id = :persona_id AND curso_id = :curso_id";
        return $this->bd->execute($query, [
            ':costo_id'=>$nuevoCostoId, 
            ':persona_id'=>$personaId, 
            ':curso_id'=>$cursoId]);
    }

    // Obtener todas las inscripciones
    public function obtenerTodasLasInscripciones() {
        $query= "SELECT ic.*, p.nombre AS persona_nombre, c.nombre AS curso_nombre, cc.monto AS costo_monto
            FROM {$this->table} ic
            JOIN persona p ON p.id = ic.persona_id
            JOIN curso c ON c.id = ic.curso_id
            LEFT JOIN costo_curso cc ON cc.id = ic.costo_id";
        return $this->bd->execute($query, PDO::FETCH_ASSOC);
    }

    // Verificar si una persona ya está inscrita a un curso
    public function estaInscrita($personaId, $cursoId) {
        $query = "SELECT COUNT(*) FROM {$this->table} WHERE persona_id = :persona_id AND curso_id = :curso_id";
        return $this->bd->execute($query, [
            ':persona_id' => $personaId, 
            ':curso_id'=> $cursoId
            ])->fetchColumn() > 0;
    }

}
?>
