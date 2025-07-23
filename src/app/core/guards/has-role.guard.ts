import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { map } from 'rxjs';
import { AuthService } from '../services/auth.service';
import { UserRole } from '../model/UserRol';

export const hasRoleGuard = (roles: UserRole[]): CanActivateFn => {
  return () => {
    const router = inject(Router);
    return inject(AuthService).currentUser$.pipe(
      map((session) => {
        if (!session) { 
          console.log('sin sessión');
          return router.createUrlTree(['login']); 
        }

        return session.roles.some(role => roles.includes(role));
      }),
    );
  };
};