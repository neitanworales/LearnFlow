import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { Session } from '../model/session/Session';

@Injectable({
  providedIn: 'root'
})
export class SessionStorageService {

  constructor() { }

  private storageChange$ = new BehaviorSubject<any>(null);

  setSession(session: Session) {
    localStorage.setItem('session', JSON.stringify(session));
    this.storageChange$.next({ session });
  }

  deleteSession() {
    localStorage.removeItem('session');
    this.storageChange$.next(null);
  }

  // observable para que los componentes se suscriban
  onChange() {
    return this.storageChange$.asObservable();
  }
}
