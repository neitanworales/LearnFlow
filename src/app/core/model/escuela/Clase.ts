import { DefaultResponse } from "../DefaultResponse";

export class Clase {
    id?: number;
    curso_id?: number;
    titulo?: string;
    descripcion?: string;
    orden?: number;
}

export class ClasesResponse extends DefaultResponse {
    data?: Clase[];
}

export class ClaseResponse extends DefaultResponse {
    data?: Clase;
}