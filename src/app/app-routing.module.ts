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
import { RegistroComponent } from './pages/registro/registro.component';
import { TerminosCondicionesComponent } from './pages/terminos-condiciones/terminos-condiciones.component';
import { hasRoleGuard } from './core/guards/has-role.guard';
import { authGuard } from './core/guards/auth.guard';
import { ClaseComponent } from './pages/learn-flow/clase/clase.component';
import { CentralComponent } from './pages/congre/central/central.component';
import { CoyoacanComponent } from './pages/congre/coyoacan/coyoacan.component';
import { AcapulcoComponent } from './pages/congre/acapulco/acapulco.component';
import { MetepecComponent } from './pages/congre/metepec/metepec.component';
import { VisionMisionObjetivosComponent } from './pages/faro/vision-mision-objetivos/vision-mision-objetivos.component';
import { DeclaracionFeComponent } from './pages/faro/declaracion-fe/declaracion-fe.component';
import { StoreComponent } from './pages/store/store.component';

const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'vision', component: VisionMisionObjetivosComponent },
  { path: 'declaracion-fe', component: DeclaracionFeComponent },
  { path: 'login', component: LoginComponent },
  { path: 'registro', component: RegistroComponent },
  { path: 'terminos-condiciones', component: TerminosCondicionesComponent },
  { path: 'central', component: CentralComponent },
  { path: 'coyoacan', component: CoyoacanComponent },
  { path: 'acapulco', component: AcapulcoComponent },
  { path: 'metepec', component: MetepecComponent },
  { path: 'store', component: StoreComponent },
  { path: 'learn-flow/main', component: MainComponent },
  { path: 'learn-flow/cursos', component: CursosComponent},
  { path: 'learn-flow/cursos/:id', component: CursoComponent},
  { path: 'learn-flow/clases/:id', component: ClaseComponent},
  { path: 'learn-flow/dashboard', component: DashboardComponent, canMatch: [authGuard] },
  { path: 'learn-flow/admin/usuarios', component: UsuariosComponent, canActivate: [hasRoleGuard(['super', 'admin'])] },
  { path: 'learn-flow/admin/alumnos', component: AlumnosComponent, canActivate: [hasRoleGuard(['super', 'admin'])] },
  { path: 'learn-flow/admin/cursos', component: MtoCursosComponent, canActivate: [hasRoleGuard(['super', 'admin'])] },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
