<?php
require_once './config/Db.class.php';

class ProgresoDao {
    private $table = 'progreso';
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
        
        $obj->id = $this->bd->executeWithId($query, $params);
        return $obj;
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

    public function obtenerAvanceCurso($persona_id, $curso_id) {
        $query = "SELECT * FROM {$this->table} WHERE persona_id = :persona_id AND curso_id = :curso_id";
        $stmt = $this->bd->execute($query, [':persona_id' => $persona_id, ':curso_id' => $curso_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function obtenerAvanceCursoClase($persona_id, $curso_id, $clase_id) {
        $query = "SELECT * FROM {$this->table} WHERE persona_id = :persona_id AND curso_id = :curso_id AND clase_id = :clase_id";
        $stmt = $this->bd->execute($query, [':persona_id' => $persona_id, ':curso_id' => $curso_id, ':clase_id' => $clase_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function obtenerAvanceCursoClaseArchivo($persona_id, $curso_id, $clase_id, $archivo_id) {
        $query = "SELECT * FROM {$this->table} WHERE persona_id = :persona_id AND curso_id = :curso_id AND clase_id = :clase_id AND archivo_id = :archivo_id";
        $stmt = $this->bd->execute($query, [':persona_id' => $persona_id, ':curso_id' => $curso_id, ':clase_id' => $clase_id, ':archivo_id' => $archivo_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>
