<?php
class UserTokenDAO
{
    private $bd;
    private $table = "user_token";

    public function __construct()
    {
        $this->bd = Db::getInstance();
    }

    // Crear un nuevo token para un usuario
    public function create($user_id, $token, $expires_at = null)
    {
        $sql = "INSERT INTO {$this->table} (user_id, token, expires_at)
                VALUES (:user_id, :token, :expires_at)";
        $stmt = $this->bd->execute($sql, [
            ':user_id' => $user_id,
            ':token' => $token,
            ':expires_at' => $expires_at
        ]);
        return $stmt;
    }

    // Obtener token por valor
    public function getByToken($token)
    {
        $sql = "SELECT * FROM {$this->table} WHERE token = :token LIMIT 1";
        $stmt = $this->bd->execute( $sql, [':token' => $token]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Obtener tokens activos de un usuario
    public function getActiveTokensByUser($user_id)
    {
        $sql = "SELECT * FROM {$this->table} 
                WHERE user_id = :user_id AND is_active = TRUE 
                AND (expires_at IS NULL OR expires_at > NOW())";
        $stmt = $this->bd->execute($sql, [':user_id' => $user_id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Revocar (desactivar) un token
    public function revokeToken($token)
    {
        $sql = "UPDATE {$this->table} SET is_active = FALSE WHERE token = :token";
        $stmt = $this->bd->execute($sql,[':token' => $token]);
        return $stmt;
    }

    // Revocar todos los tokens activos de un usuario
    public function revokeAll($user_id)
    {
        $sql = "UPDATE {$this->table} 
                SET is_active = FALSE 
                WHERE user_id = :user_id AND is_active = TRUE";
        $stmt = $this->bd->execute($sql,[':user_id' => $user_id]);
        return $stmt;
    }
}
?>