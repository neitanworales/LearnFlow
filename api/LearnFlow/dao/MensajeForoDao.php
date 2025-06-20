<?php
require_once './config/Db.class.php';

class MensajeForoDao {
    private $table = 'mensajes_foro';
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
}
?>
