import { Injectable, NgZone } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class LocalStorageListenerService {
    private storageSubject = new BehaviorSubject<any>(this.getItem());

    constructor(private ngZone: NgZone) {
        window.addEventListener('storage', (event) => {
            if (event.key === 'nombreDelObjeto') {
                this.ngZone.run(() => {
                    this.storageSubject.next(this.getItem());
                });
            }
        });
    }

    get changes$() {
        return this.storageSubject.asObservable();
    }

    getItem() {
        const item = localStorage.getItem('nombreDelObjeto');
        return item ? JSON.parse(item) : null;
    }

    setItem(value: any) {
        localStorage.setItem('nombreDelObjeto', JSON.stringify(value));
        this.storageSubject.next(value); // Notifica también en la misma pestaña
    }
}