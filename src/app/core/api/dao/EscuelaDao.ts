import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Utils } from "../Utils";
import { environment } from "src/environments/environment";
import { Observable } from "rxjs";
import { CursoResponse, CursosResponse } from "../../model/escuela/Curso";
import { Clase, ClaseResponse } from "../../model/escuela/Clase";
import { DefaultResponse } from "../../model/DefaultResponse";
import { Persona } from "../../model/Persona";
import { Inscripcion } from "../../model/escuela/Inscripcion";
import { Session } from "../../model/session/Session";

@Injectable()
export class EscuelaDao {
    constructor(
        private http: HttpClient,
        private utils: Utils
    ) { }

    public getCursos(): Observable<CursosResponse> {
        return this.http.get<CursosResponse>(environment.api + '/api/cursos', { headers: this.utils.getHeaders() });
    }

    public getCurso(id: number): Observable<CursoResponse> {
        return this.http.get<CursoResponse>(environment.api + '/api/cursos/' + id, { headers: this.utils.getHeaders() });
    }

    public getClase(id: number): Observable<ClaseResponse> {
        return this.http.get<ClaseResponse>(environment.api + '/api/clases/'+id, { headers: this.utils.getHeaders() });
    }

    public inscribir(inscripcion: Inscripcion): Observable<DefaultResponse> {
        let session : Session = this.utils.getSessionFromStorage()!;
        inscripcion.persona_id = session?.persona_id;
        return this.http.post<DefaultResponse>(environment.api + '/api/inscripciones', inscripcion, { headers: this.utils.getHeaders() });
    }

    public getCursosByPersona(): Observable<CursosResponse> {
        let session : Session = this.utils.getSessionFromStorage()!;
        return this.http.get<CursosResponse>(environment.api + '/api/inscripciones/persona/'+session.persona_id, { headers: this.utils.getHeaders() });
    }
}