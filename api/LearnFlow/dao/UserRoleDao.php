<?php
require_once './config/Db.class.php';
class UserRoleDAO
{
    private $bd;
    private $table = "user_role";

    public function __construct()
    {
        $this->bd = Db::getInstance();
    }

    // Asignar un rol a un usuario
    public function assignRole($user_id, $role_id)
    {
        $sql = "INSERT INTO {$this->table} (user_id, role_id) VALUES (:user_id, :role_id)";
        $stmt = $this->bd->execute($sql, [
            ':user_id' => $user_id,
            ':role_id' => $role_id
        ]);
        return $stmt;
    }

    // Eliminar un rol específico de un usuario
    public function removeRole($user_id, $role_id)
    {
        $sql = "DELETE FROM {$this->table} WHERE user_id = :user_id AND role_id = :role_id";
        $stmt = $this->bd->execute($sql, [
            ':user_id' => $user_id,
            ':role_id' => $role_id
        ]);
        return $stmt;
    }

    // Eliminar todos los roles de un usuario
    public function removeAllRoles($user_id)
    {
        $sql = "DELETE FROM {$this->table} WHERE user_id = :user_id";
        $stmt = $this->bd->execute($sql, [':user_id' => $user_id]);
        return $stmt;
    }

    // Obtener todos los roles de un usuario
    public function getRolesByUser($user_id)
    {
        $sql = "SELECT r.id, r.nombre
                FROM roles r
                INNER JOIN {$this->table} ur ON r.id = ur.role_id
                WHERE ur.user_id = :user_id";
        $stmt = $this->bd->execute($sql, [':user_id' => $user_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Obtener todos los usuarios que tienen un rol específico
    public function getUsersByRole($role_id)
    {
        $sql = "SELECT u.id, u.name, u.email
                FROM usuarios u
                INNER JOIN {$this->table} ur ON u.id = ur.user_id
                WHERE ur.role_id = :role_id";
        $stmt = $this->bd->execute($sql, [':role_id' => $role_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>