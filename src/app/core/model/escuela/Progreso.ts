export class Progreso {
    id?: number;
    persona_id?: number;
    curso_id?: number;
    clase_id?: number;
    archivo_id?: number;
    avance?: number; // en segundos
    porcentaje?: number; // 0 a 100
    terminado?: boolean;
    fecha_actualizacion?: Date;
}

export class ProgresoResponse {
    data?: Progreso[];
}