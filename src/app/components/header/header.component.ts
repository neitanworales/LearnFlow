import { Component } from '@angular/core';

@Component({
    selector: 'app-header',
    templateUrl: './header.component.html',
    styleUrls: ['./header.component.scss'],
    standalone: false
})
export class HeaderComponent {

    isAdmin = false;
    isLoggedIn = false;

    // This component checks if the user is logged in and if they are an admin
    // It also provides a logout function to clear the user session
    // and reload the page.

    constructor() {
        // Check if the user is an admin
        const user = localStorage.getItem('user');
        if (user) {
            this.isLoggedIn = true;
            const parsedUser = JSON.parse(user);
            this.isAdmin = parsedUser.roles === 'admin';
        } else {
            this.isLoggedIn = false;
            this.isAdmin = false;
        }
    }

    logout() {
        localStorage.removeItem('user');
        window.location.reload();
    }

}
