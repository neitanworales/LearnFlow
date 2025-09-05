import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { EscuelaDao } from 'src/app/core/api/dao/EscuelaDao';
import { Clase } from 'src/app/core/model/escuela/Clase';
import { VideoPlayerComponent } from "../../../components/video-player/video-player.component";
import { RecursosClaseComponent } from 'src/app/components/recursos-clase/recursos-clase.component';


@Component({
  selector: 'app-clase',
  imports: [CommonModule, RecursosClaseComponent],
  templateUrl: './clase.component.html',
  styleUrl: './clase.component.scss'
})
export class ClaseComponent {

  clase?: Clase;

  constructor(
    private route: ActivatedRoute,
    private escuelaDao: EscuelaDao
  ) { 

  }

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const claseId = Number(params.get('id'));
      if (claseId) {
        this.escuelaDao.getClase(claseId).subscribe(response => {
          this.clase = response.data;
        });
      } else {
        console.error('Invalid clase ID');
      }
    });
  }

  
}
