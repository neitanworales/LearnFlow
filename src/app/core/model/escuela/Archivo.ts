import { TipoArchivo } from "./TipoArchivo";

export class Archivo {
    id?: number;
    titulo?: string;
    url_archivo?: string;
    tipo?: TipoArchivo | undefined; // 'pdf' | 'audio' | 'video' | 'imagen' | 'otro'
    fecha_subida?: Date;
    duracion?: string; // Formato: "HH:MM:SS"
}