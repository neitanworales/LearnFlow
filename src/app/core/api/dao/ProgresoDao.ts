import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable, of } from "rxjs";
import { Utils } from "../Utils";
import { environment } from "src/environments/environment";
import { Progreso, ProgresoResponse } from "../../model/escuela/Progreso";
import { DefaultResponse } from "../../model/DefaultResponse";

@Injectable()
export class ProgresoDao {
    constructor(
        private http: HttpClient,
        private utils: Utils
    ) { }

    public guardarProgresoArchivo(progreso: Progreso): Observable<DefaultResponse | null> {
        let session = this.utils.getSessionFromStorageWithoutRedirect();
        if (!session)
            return of(null);
        let personaId = session.persona_id;
        progreso.persona_id = personaId;
        return this.http.post<DefaultResponse>(environment.api + '/progreso', progreso, { headers: this.utils.getHeaders() });
    }

    public actualizarProgresoArchivo(progresoId: number, avance: number, porcentaje: number): Observable<DefaultResponse | null> {
        const body = {
            avance: avance,
            porcentaje: porcentaje
        };
        let session = this.utils.getSessionFromStorageWithoutRedirect();
        if (!session)
            return of(null);
        return this.http.put<DefaultResponse>(environment.api + '/progreso/' + progresoId, body, { headers: this.utils.getHeaders() });
    }

    public obtenerProgresoArchivo(progresoId: number): any {
        return this.http.get<any>(environment.api + '/progreso/' + progresoId, { headers: this.utils.getHeaders() });
    }

    public obtenerProgresoArchivoByTraza(cursoId: number, claseId: number, archivoId: number): Observable<ProgresoResponse | null> {
        let session = this.utils.getSessionFromStorageWithoutRedirect();
        if (!session)
            return of(null);
        let personaId = session?.persona_id;
        return this.http.get<ProgresoResponse>(environment.api + '/progreso/' + personaId + '/cursos/' + cursoId + '/clases/' + claseId + '/archivos/' + archivoId, { headers: this.utils.getHeaders() });
    }

    public saveProgresoToLocalStorage(progreso: Progreso) {
        let progresos: Progreso[] = JSON.parse(localStorage.getItem('progresos')!) || [];
        const index = progresos.findIndex(p => p.archivo_id === progreso.archivo_id && p.clase_id === progreso.clase_id && p.curso_id === progreso.curso_id);
        if (index !== -1) {
            progresos[index] = progreso;
        } else {
            progresos.push(progreso);
        }
        localStorage.setItem('progresos', JSON.stringify(progresos));
    }

    public getProgresosFromLocalStorage(archivo_id: number, clase_id: number, curso_id: number): Progreso | null {
        let progresos: Progreso[] = JSON.parse(localStorage.getItem('progresos')!) || [];
        const index = progresos.findIndex(p => p.archivo_id === archivo_id && p.clase_id === clase_id && p.curso_id === curso_id);
        if (index !== -1) {
            return progresos[index];
        }
        return null;
    }
}