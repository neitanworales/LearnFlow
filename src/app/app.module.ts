import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HTTP_INTERCEPTORS, provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';

import { MatTableModule } from '@angular/material/table';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { UsuariosComponent } from './pages/learn-flow/private/usuarios/usuarios.component';
import { AlumnosComponent } from './pages/learn-flow/private/alumnos/alumnos.component';
import { DashboardComponent } from './pages/learn-flow/private/dashboard/dashboard.component';
import { MainComponent } from './pages/learn-flow/main/main.component';
import { HomeComponent } from './pages/home/home.component';
import { LoginComponent } from './pages/login/login.component';
import { HeaderComponent } from './components/header/header.component';
import { FooterComponent } from './components/footer/footer.component';
import { RegistroComponent } from './pages/registro/registro.component';
import { MtoCursosComponent } from './pages/learn-flow/private/mto-cursos/mto-cursos.component';
import { CursosComponent } from './pages/learn-flow/cursos/cursos.component';
import { CursoComponent } from './pages/learn-flow/curso/curso.component';
import { UsuarioDao } from './core/api/dao/UsuarioDao';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { TerminosCondicionesComponent } from './pages/terminos-condiciones/terminos-condiciones.component';
import { LogInDao } from './core/api/dao/LogInDao';
import { AuthInterceptor } from './core/services/ auth.interceptor';
import { AuthService } from './core/services/auth.service';
import { TumbaService } from './core/services/tumbaService';
import { Utils } from './core/api/Utils';
import { Router } from '@angular/router';
import { LocalStorageListenerService } from './core/services/LocalStorageListenerService';
import { Curso } from './core/model/escuela/Curso';
import { CursoDao } from './core/api/dao/CursoDao';

@NgModule({
  declarations: [
    AppComponent,
    UsuariosComponent,
    AlumnosComponent,
    DashboardComponent,
    MainComponent,
    HomeComponent,
    LoginComponent,
    HeaderComponent,
    FooterComponent,
    RegistroComponent,
    CursosComponent,
    MtoCursosComponent,
    CursoComponent,
    TerminosCondicionesComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatTableModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  providers: [
    {
      provide: 'router', useFactory: (rotuer: Router) => {
        return new Router();
      }
    },
    //{ provide: HTTP_INTERCEPTORS, useClass: LoadingInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true },
    provideHttpClient(withInterceptorsFromDi()),
    Utils,
    UsuarioDao,
    CursoDao,
    LogInDao,
    AuthService,
    TumbaService,
    LocalStorageListenerService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
