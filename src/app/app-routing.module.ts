import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { LoginComponent } from './pages/login/login.component';
import { AlumnosComponent } from './pages/learn-flow/private/alumnos/alumnos.component';
import { DashboardComponent } from './pages/learn-flow/private/dashboard/dashboard.component';
import { MateriasComponent } from './pages/learn-flow/private/materias/materias.component';
import { MainComponent } from './pages/learn-flow/main/main.component';

const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'login', component: LoginComponent },
  { path: 'learn-flow/main', component: MainComponent },
  { path: 'learn-flow/dashboard', component: DashboardComponent },
  { path: 'learn-flow/admin/alumnos', component: AlumnosComponent },
  { path: 'learn-flow/admin/materias', component: MateriasComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
