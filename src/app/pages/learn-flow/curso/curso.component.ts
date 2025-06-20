import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CursoDao } from 'src/app/core/api/dao/CursoDao';
import { Curso } from 'src/app/core/model/escuela/Curso';


@Component({
    selector: 'app-curso',
    templateUrl: './curso.component.html',
    styleUrls: ['./curso.component.scss'],
    standalone: false
})
export class CursoComponent implements OnInit {
    cursoId: number = 0;
    curso?: Curso;
    tags: string[] = [];

    constructor(
        private route: ActivatedRoute,
        private cursoDao: CursoDao
    ) { }

    ngOnInit(): void {
        this.route.paramMap.subscribe(params => {
            this.cursoId = Number(params.get('id'));
            if (this.cursoId) {
                this.cursoDao.getCurso(this.cursoId).subscribe(response => {
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
}
