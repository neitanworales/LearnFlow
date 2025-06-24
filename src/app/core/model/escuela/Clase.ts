import { DefaultResponse } from "../DefaultResponse";
import { Archivo } from "./Archivo";

export class Clase {
    id?: number;
    curso_id?: number;
    titulo?: string;
    descripcion?: string;
    orden?: number;
    recursos?: Archivo[];
}

export class ClasesResponse extends DefaultResponse {
    data?: Clase[];
}

export class ClaseResponse extends DefaultResponse {
    data?: Clase;
}