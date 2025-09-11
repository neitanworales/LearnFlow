<?php
class Progreso
{
    public int $id;
    public int $persona_id;
    public int $curso_id;
    public int $clase_id;
    public int $archivo_id;
    public ?string $avance;
    public float $porcentaje;
    public ?bool $terminado;
    public ?string $ultima_actualizacion;
}
?>