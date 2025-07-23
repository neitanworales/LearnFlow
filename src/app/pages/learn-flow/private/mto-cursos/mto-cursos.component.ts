import { Component, OnInit } from '@angular/core';
import { EscuelaDao } from 'src/app/core/api/dao/EscuelaDao';
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
        private escuelaDao: EscuelaDao
    ) { }

    ngOnInit(): void {
        this.cargarDatos();
    }

    cargarDatos() {
        this.escuelaDao.getCursos().subscribe(
            result => {
                if (result.status === 'Ok') {
                    this.data = result.data || [];
                } else {
                    console.error('Error al cargar los cursos:', result.status);
                }
            });
    }

}
