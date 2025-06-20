import { Component, OnInit } from '@angular/core';
import { CursoDao } from 'src/app/core/api/dao/CursoDao';
import { Curso } from 'src/app/core/model/escuela/Curso';

@Component({
    selector: 'app-mto-cursos',
    templateUrl: './mto-cursos.component.html',
    styleUrls: ['./mto-cursos.component.scss'],
    standalone: false
})
export class MtoCursosComponent implements OnInit {

    data: Curso[] = new Array();

    columnsToDisplay = [
        'id',
        'organizacion_id',
        'titulo',
        'descripcion',
        'fecha_inicio',
        'fecha_fin',
        'instructor_id',
        'estado',
        'imagen_url',
        'duracion_horas',
        'requisitos',
        'certificado_disponible',
        'precio',
    ];

    constructor(
        private cursoDao: CursoDao
    ) { }

    ngOnInit(): void {
        this.cargarDatos();
    }

    cargarDatos() {
        this.cursoDao.getCursos().subscribe(
            result => {
                if (result.status === 'Ok') {
                    this.data = result.data || [];
                } else {
                    console.error('Error al cargar los cursos:', result.status);
                }
            });
    }

}
