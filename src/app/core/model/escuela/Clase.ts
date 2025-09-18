import { DefaultResponse } from "../DefaultResponse";
import { Archivo } from "./Archivo";

export class Clase {
    id?: number;
    curso_id?: number;
    titulo?: string;
    descripcion?: string;
    orden?: number;
    recursos?: Archivo[];
    curso_titulo?: string;
    tiempo_clase?: string; // Formato "HH:MM:SS"
    tiene_pdf?: boolean;
    tiene_video?: boolean;
    tiene_audio?: boolean;
    avance?: number; // Porcentaje de avance
}

export class ClasesResponse extends DefaultResponse {
    data?: Clase[];
}

export class ClaseResponse extends DefaultResponse {
    data?: Clase;
}