import { DefaultResponse } from "../DefaultResponse";
import { Persona } from "../Persona";

export class Curso {
    id?: number;
    organizacion_id?: number;
    titulo?: string;
    descripcion_corta?: string;
    descripcion?: string;
    tags?: string;
    fecha_inicio?: Date;
    fecha_fin?: Date;
    instructor_id?: number;
    estado?: boolean;
    imagen_url?: string;
    duracion_horas?: number;
    requisitos?: string;
    certificado_disponible?: boolean;
    precio?: number;
    autor?: Persona
}

export class CursosResponse extends DefaultResponse {
    data?: Curso[];
}

export class CursoResponse extends DefaultResponse {
    data?: Curso;
}