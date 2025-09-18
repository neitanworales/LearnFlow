import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Utils } from 'src/app/core/api/Utils';
import { Curso } from 'src/app/core/model/escuela/Curso';

@Component({
  selector: 'app-lista-cursos',
  imports: [RouterModule, CommonModule],
  standalone: true,
  templateUrl: './lista-cursos.component.html',
  styleUrl: './lista-cursos.component.scss'
})
export class ListaCursosComponent {

  Utils = Utils;
  @Input() cursos!: Curso[];

}
