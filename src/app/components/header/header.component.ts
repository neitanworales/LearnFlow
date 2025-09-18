import { Component, OnInit } from '@angular/core';
import { Utils } from 'src/app/core/api/Utils';
import { Session } from 'src/app/core/model/session/Session';
import { SessionStorageService } from 'src/app/core/services/session-storage.service';

@Component({
    selector: 'app-header',
    templateUrl: './header.component.html',
    styleUrls: ['./header.component.scss'],
    standalone: false
})
export class HeaderComponent implements OnInit {

    isAdmin = false;
    isLoggedIn = false;
    session!: Session;

    constructor(
        private utils: Utils,
        private storage: SessionStorageService
    ) {}

    ngOnInit(): void {
        this.storage.onChange().subscribe(session => {
            if (session) {
                this.session = session.session;
                this.isLoggedIn = true;
                this.isAdmin = session.session.roles.includes('admin');
            } else {
                this.isLoggedIn = false;
                this.isAdmin = false;
            }
        });
        this.session = this.utils.getSessionFromStorageWithoutRedirect()!;
        if(this.session) {
            this.isLoggedIn = true;
            this.isAdmin = this.session.roles.includes('admin');
        }
    }

    logout() {
        localStorage.removeItem('session');
        window.location.reload();
    }

}
