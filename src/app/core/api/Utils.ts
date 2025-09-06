import { HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Router } from "@angular/router";
import { Session } from "../model/session/Session";

@Injectable()
export class Utils {

    constructor(
        private router: Router
    ) { }

    public getHeaders(): HttpHeaders {
        //const user = JSON.parse(localStorage.getItem('currentUser')!);
        return new HttpHeaders({
            'Content-Type': 'application/json',
            //'Authorization': `Bearer ${user.token}`
        });
    }

    public getSessionFromStorage(): Session | undefined {
        console.log(localStorage.getItem('session'));
        if (localStorage.getItem('session') == null) {
            console.log("redireccionará");
            this.router.navigate(["/login"]);
            return undefined;
        } else {
            return JSON.parse(localStorage.getItem('session')!);
        }
    }

    static getDriveImageUrl(fileId: string): string {
        return 'https://www.neitanworales.com/api/learn-flow/proxy-image.php?id='+fileId;
    }

}