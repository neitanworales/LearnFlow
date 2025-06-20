import { Component, OnInit } from '@angular/core';
import { CursoDao } from 'src/app/core/api/dao/CursoDao';
import { Curso } from 'src/app/core/model/escuela/Curso';

@Component({
    selector: 'app-cursos',
    templateUrl: './cursos.component.html',
    styleUrls: ['./cursos.component.scss'],
    standalone: false
})
export class CursosComponent implements OnInit {
    
    cursos: Curso[] = new Array();

    constructor(
        private cursoDao: CursoDao
    ) { 

    }

    ngOnInit(): void {
        this.cargarCursos();
    }

    cargarCursos() {
        this.cursoDao.getCursos().subscribe(
            result => {
                if (result.status === 'Ok') {
                    this.cursos = result.data || [];
                } else {
                    console.error('Error al cargar los cursos:', result.status);
                }
            });
    }

}
