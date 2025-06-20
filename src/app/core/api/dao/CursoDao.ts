import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Utils } from "../Utils";
import { environment } from "src/environments/environment";
import { Observable } from "rxjs";
import { CursoResponse, CursosResponse } from "../../model/escuela/Curso";

@Injectable()
export class CursoDao {
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
}