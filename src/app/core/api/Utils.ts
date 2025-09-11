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
            let session: Session = JSON.parse(localStorage.getItem('session')!)
            if (session.expires_at && new Date(session.expires_at) < new Date()) {
                return undefined;
            }
            console.log("session obtenida de storage", session);
            return session;
        }
    }

        public getSessionFromStorageWithoutRedirect(): Session | undefined {
        console.log(localStorage.getItem('session'));
        if (localStorage.getItem('session') == null) {
            return undefined;
        } else {
            let session: Session = JSON.parse(localStorage.getItem('session')!)
            if (session.expires_at && new Date(session.expires_at) < new Date()) {
                return undefined;
            }
            console.log("session obtenida de storage", session);
            return session;
        }
    }

    static getDriveImageUrl(fileId: string): string {
        if(!fileId || fileId.trim() === '') {
            return '';
        }
        return 'https://www.neitanworales.com/api/learn-flow/proxy-image.php?id=' + fileId;
    }

}