import { Injectable } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";
import { UsuarioResponse } from "../../model/UsuarioResponse";
import { environment } from "src/environments/environment";
import { DefaultResponse } from "../../model/DefaultResponse";
import { Usuario } from "../../model/Usuario";

@Injectable()
export class UsuarioDao {
    constructor(
        private http: HttpClient
    ) { }

    public getUsuarios(): Observable<UsuarioResponse> {
        return this.http.get<UsuarioResponse>(environment.api + '/usuarios');
    }

    public guardarUsuario(usuario: Usuario): Observable<DefaultResponse> {
        return this.http.post<DefaultResponse>(environment.api+'/usuarios', usuario);
    }
}