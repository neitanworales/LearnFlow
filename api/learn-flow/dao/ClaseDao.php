<?php
require_once './config/Db.class.php';
class ClaseDao
{
    private $db;
    private $table = "clase";

    public function __construct()
    {
        $this->db = Db::getInstance();
    }

    // Crear una clase
    public function create($curso_id, $titulo, $descripcion, $orden)
    {
        $sql = "INSERT INTO {$this->table} (curso_id, título, descripcion, orden)
                VALUES (:curso_id, :titulo, :descripcion, :orden)";
        return $this->db->executeWithId($sql, [
            ':curso_id' => $curso_id,
            ':titulo' => $titulo,
            ':descripcion' => $descripcion,
            ':orden' => $orden
        ]);
    }

    // Obtener todas las clases
    public function getAll()
    {
        $sql = "SELECT * FROM {$this->table} ORDER BY orden DESC";
        return $this->db->execute($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    // Obtener clases por curso
    public function getByCurso($curso_id)
    {
        $sql = "SELECT * FROM {$this->table} WHERE curso_id = :curso_id ORDER BY orden DESC";
        return $this->db->execute($sql, [':curso_id' => $curso_id])->fetchAll(PDO::FETCH_ASSOC);
    }

    // Obtener clase por ID
    public function getById($id)
    {
        $sql = "SELECT * FROM {$this->table} WHERE id = :id";
        return $this->db->execute($sql, [':id' => $id])->fetch(PDO::FETCH_ASSOC);
    }

    // Actualizar clase
    public function update($id, $curso_id, $titulo, $descripcion, $orden)
    {
        $sql = "UPDATE {$this->table} 
                SET curso_id = :curso_id, título = :titulo, descripcion = :descripcion, orden = :orden
                WHERE id = :id";
        return $this->db->execute($sql, [
            ':id' => $id,
            ':curso_id' => $curso_id,
            ':titulo' => $titulo,
            ':descripcion' => $descripcion,
            ':orden' => $orden
        ]);
    }

    // Eliminar clase
    public function delete($id)
    {
        $sql = "DELETE FROM {$this->table} WHERE id = :id";
        return $this->db->execute([':id' => $id]);
    }
}
?>