import { Component, OnInit } from '@angular/core';
import { Utils } from 'src/app/core/api/Utils';
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

    // This component checks if the user is logged in and if they are an admin
    // It also provides a logout function to clear the user session
    // and reload the page.

    constructor(
        utils: Utils,
        private storage: SessionStorageService
    ) {
        // Check if the user is an admin
        const session = utils.getSessionFromStorageWithoutRedirect();
        if (session) {
            this.isLoggedIn = true;
            this.isAdmin = session.roles.includes('admin');
        } else {
            this.isLoggedIn = false;
            this.isAdmin = false;
        }
    }
    ngOnInit(): void {
        this.storage.onChange().subscribe(session => {
            if (session && session.session) {
                this.isLoggedIn = true;
                this.isAdmin = session.session.roles.includes('admin');
            } else {
                this.isLoggedIn = false;
                this.isAdmin = false;
            }
        });
    }

    logout() {
        localStorage.removeItem('session');
        window.location.reload();
    }

}
