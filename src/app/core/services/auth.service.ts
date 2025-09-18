import { BehaviorSubject, catchError, firstValueFrom, map, Observable, of } from 'rxjs';
import { inject, Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { LogInDao } from '../api/dao/LogInDao';
import { Session } from '../model/session/Session';
import { SessionStorageService } from './session-storage.service';
import { Utils } from '../api/Utils';

@Injectable()
export class AuthService {
  constructor(
    private loginDao: LogInDao,
    private storage: SessionStorageService,
    private utils: Utils
  ) { }

  private _currentUser = new BehaviorSubject<Session | null>(this.getSession());
  currentUser$ = this._currentUser.asObservable();
  authorized: Session | null = null;
  router = inject(Router);

  getSession(): Session | null {
    const session = this.utils.getSessionFromStorageWithoutRedirect();
    if (session) {
      this.loginDao.getSession().subscribe(
        result => {
          this.storage.setSession(result.data!);
        }, error => {
          this.setSession(null);
          this.storage.deleteSession();
        }
      );
      return this.utils.getSessionFromStorageWithoutRedirect()!;
    } else {
      return null;
    }
  }

  getSessionValida(): Session {
    return this.utils.getSessionFromStorageWithoutRedirect()!;
  }

  setSession(session: Session | null) {
    this._currentUser.next(session);
  }
}