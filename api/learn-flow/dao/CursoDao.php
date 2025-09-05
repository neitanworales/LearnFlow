<?php
require_once './config/Db.class.php';

class CursoDao {
    private $table = 'cursos';
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
    
    public function getCursoTituloByClaseId($curso_id) {
        $query = "SELECT titulo FROM {$this->table} WHERE id = :curso_id";
        $stmt = $this->bd->execute($query, [':curso_id' => $curso_id]);
        $result = $stmt ? $stmt->fetch(PDO::FETCH_ASSOC) : false;
        return $result ? $result['titulo'] : null;
    }
}
?>
