import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

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
    CursoComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
