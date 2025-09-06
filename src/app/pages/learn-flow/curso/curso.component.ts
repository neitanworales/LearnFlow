import { AfterViewInit, Component, ElementRef, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { EscuelaDao } from 'src/app/core/api/dao/EscuelaDao';
import { Curso } from 'src/app/core/model/escuela/Curso';
import { jarallax } from 'jarallax';
import { Inscripcion } from 'src/app/core/model/escuela/Inscripcion';
import { Utils } from 'src/app/core/api/Utils';

@Component({
    selector: 'app-curso',
    templateUrl: './curso.component.html',
    styleUrls: ['./curso.component.scss'],
    standalone: false
})
export class CursoComponent implements OnInit, AfterViewInit {

    Utils = Utils;
    cursoId: number = 0;
    curso?: Curso;
    tags: string[] = [];

    constructor(
        private route: ActivatedRoute,
        private escuelaDao: EscuelaDao,
        private elRef: ElementRef
    ) { }

    ngAfterViewInit(): void {
        jarallax(this.elRef.nativeElement.querySelectorAll('.jarallax'), {
            speed: 0.5
        });
    }

    ngOnInit(): void {
        this.route.paramMap.subscribe(params => {
            this.cursoId = Number(params.get('id'));
            if (this.cursoId) {
                this.escuelaDao.getCurso(this.cursoId).subscribe(response => {
                    console.log(response.data);
                    this.curso = response.data;
                    if (this.curso && this.curso.tags) {
                        this.tags = this.curso.tags.split(',').map(tag => tag.trim());
                    } else {
                        this.tags = [];
                    }
                });
            } else {
                console.error('Invalid curso ID');
            }
        });
    }

    tomarCurso(curso: Curso): void {
        if (curso && curso.clases && curso.clases.length > 0) {
            const firstClassId = curso.clases[0].id;
            // Navigate to the first class of the course

            let inscripcion: Inscripcion = new Inscripcion();
            inscripcion.curso_id = curso.id;
            this.escuelaDao.inscribir(inscripcion).subscribe(response => {
                console.log('Inscripción exitosa:', response);
                window.location.href = `/learn-flow/clases/${firstClassId}`;
            });

        } else {
            console.error('No classes available for this course');
        }
    }
}
