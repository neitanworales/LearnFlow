import { Component, OnInit } from '@angular/core';
import { EscuelaDao } from 'src/app/core/api/dao/EscuelaDao';
import { Curso } from 'src/app/core/model/escuela/Curso';
import { Utils } from 'src/app/core/api/Utils';

@Component({
    selector: 'app-cursos',
    templateUrl: './cursos.component.html',
    styleUrls: ['./cursos.component.scss'],
    standalone: false
})
export class CursosComponent implements OnInit {
    
    Utils = Utils;
    cursos: Curso[] = new Array();

    constructor(
        private escuelaDao: EscuelaDao
    ) { 

    }

    ngOnInit(): void {
        this.cargarCursos();
    }

    cargarCursos() {
        this.escuelaDao.getCursos().subscribe(
            result => {
                if (result.status === 'Ok') {
                    this.cursos = result.data || [];
                } else {
                    console.error('Error al cargar los cursos:', result.status);
                }
            });
    }

}
