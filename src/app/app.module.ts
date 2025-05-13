import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FooterComponent } from './components/footer/footer.component';
import { HeaderComponent } from './components/header/header.component';
import { LoginComponent } from './pages/login/login.component';
import { HomeComponent } from './pages/home/home.component';
import { MainComponent } from './pages/learn-flow/main/main.component';
import { DashboardComponent } from './pages/learn-flow/private/dashboard/dashboard.component';
import { AlumnosComponent } from './pages/learn-flow/private/alumnos/alumnos.component';
import { MateriasComponent } from './pages/learn-flow/private/materias/materias.component';
import { UsuariosComponent } from './pages/learn-flow/private/usuarios/usuarios.component';

@NgModule({
  declarations: [
    AppComponent,
    FooterComponent,
    HeaderComponent,
    LoginComponent,
    HomeComponent,
    MainComponent,
    DashboardComponent,
    AlumnosComponent,
    MateriasComponent,
    UsuariosComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
