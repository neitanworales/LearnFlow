import { Component, OnInit } from '@angular/core';
import { EscuelaDao } from 'src/app/core/api/dao/EscuelaDao';
import { Curso } from 'src/app/core/model/escuela/Curso';

@Component({
    selector: 'app-dashboard',
    templateUrl: './dashboard.component.html',
    styleUrls: ['./dashboard.component.scss'],
    standalone: false
})
export class DashboardComponent implements OnInit {
    
    cursosAsignados: Curso[] = [];

    constructor(
        private escuelaDao: EscuelaDao
    ) {}

    ngOnInit(): void {
        this.loadCursosAsignados();
    }   

    loadCursosAsignados(){
        this.escuelaDao.getCursosByPersona().subscribe( response => {
            if(response.statusCode === 200) {
                console.log('Cursos asignados:', response.data);
                this.cursosAsignados = response.data!;
            } else {
                console.error('Error al cargar los cursos asignados:', response.status);
            }
        });
    }

}
