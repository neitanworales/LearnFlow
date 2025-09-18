import { HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Router } from "@angular/router";
import { Session } from "../model/session/Session";
import { SessionStorageService } from "../services/session-storage.service";

@Injectable()
export class Utils {

    constructor(
        private router: Router,
        private sessionStorage: SessionStorageService
    ) { }

    public getHeaders(): HttpHeaders {
        //const user = JSON.parse(localStorage.getItem('currentUser')!);
        return new HttpHeaders({
            'Content-Type': 'application/json',
            //'Authorization': `Bearer ${user.token}`
        });
    }

    public getSessionFromStorage(): Session | undefined {
        if (localStorage.getItem('session') == null) {
            this.router.navigate(["/login"]);
            return undefined;
        } else {
            let session: Session = this.sessionStorage.getSession()!;
            return session;
        }
    }

    public getSessionFromStorageWithoutRedirect(): Session | undefined {
        if (localStorage.getItem('session') == null) {
            return undefined;
        } else {
            let session: Session = this.sessionStorage.getSession()!;
            if (session.expires_at && new Date(session.expires_at) < new Date()) {
                return undefined;
            }
            return session;
        }
    }

    static getDriveImageUrl(fileId: string): string {
        if (!fileId || fileId.trim() === '') {
            return '';
        }
        return 'https://www.neitanworales.com/api/learn-flow/proxy-image.php?id=' + fileId;
    }

    msToTime(ms: number): string {
        const hours = Math.floor(ms / (1000 * 60 * 60));
        const minutes = Math.floor((ms % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((ms % (1000 * 60)) / 1000);

        // Formato con ceros a la izquierda
        const hh = String(hours).padStart(2, '0');
        const mm = String(minutes).padStart(2, '0');
        const ss = String(seconds).padStart(2, '0');

        return `${hh}:${mm}:${ss}`;
    }

    timeToSeconds(time: string): number {
        const parts = time.split(':').map(Number);
        // Ej: "02:03:04" → [2, 3, 4]

        const hours = parts[0] || 0;
        const minutes = parts[1] || 0;
        const seconds = parts[2] || 0;

        return (hours * 3600) + (minutes * 60) + seconds;
    }
}