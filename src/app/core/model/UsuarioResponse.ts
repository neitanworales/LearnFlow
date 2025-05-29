import { DefaultResponse } from "./DefaultResponse";
import { Usuario } from "./Usuario";

export class UsuarioResponse extends DefaultResponse {
    data?: Usuario[];
}