import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { MainComponent } from './pages/learn-flow/main/main.component';
import { AlumnosComponent } from './pages/learn-flow/private/alumnos/alumnos.component';
import { DashboardComponent } from './pages/learn-flow/private/dashboard/dashboard.component';
import { LoginComponent } from './pages/login/login.component';
import { UsuariosComponent } from './pages/learn-flow/private/usuarios/usuarios.component';
import { MtoCursosComponent } from './pages/learn-flow/private/mto-cursos/mto-cursos.component';
import { CursosComponent } from './pages/learn-flow/cursos/cursos.component';
import { CursoComponent } from './pages/learn-flow/curso/curso.component';

const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'login', component: LoginComponent },
  { path: 'learn-flow/main', component: MainComponent },
  { path: 'learn-flow/dashboard', component: DashboardComponent },
  { path: 'learn-flow/cursos', component: CursosComponent },
  { path: 'learn-flow/cursos/:id', component: CursoComponent },
  { path: 'learn-flow/admin/usuarios', component: UsuariosComponent },
  { path: 'learn-flow/admin/alumnos', component: AlumnosComponent },
  { path: 'learn-flow/admin/cursos', component: MtoCursosComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
