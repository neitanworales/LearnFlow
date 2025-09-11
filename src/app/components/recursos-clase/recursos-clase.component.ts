import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Clase } from 'src/app/core/model/escuela/Clase';
//import { VideoPlayerComponent } from '../video-player/video-player.component';
import { YoutubePlayerComponent } from '../youtube-player/youtube-player.component';
import { Progreso } from 'src/app/core/model/escuela/Progreso';
import { Archivo } from 'src/app/core/model/escuela/Archivo';
import { ProgresoDao } from 'src/app/core/api/dao/ProgresoDao';
import { DefaultResponse } from 'src/app/core/model/DefaultResponse';

@Component({
  selector: 'app-recursos-clase',
  imports: [CommonModule,
    //VideoPlayerComponent, 
    YoutubePlayerComponent],
  standalone: true,
  templateUrl: './recursos-clase.component.html',
  styleUrl: './recursos-clase.component.scss'
})
export class RecursosClaseComponent implements OnInit {

  currentTime = 0;
  duration = 0;
  lastSavedPercent = 0;
  progreso: Progreso | null = null;

  constructor(
    private progresoDao: ProgresoDao
  ) { }

  ngOnInit(): void {

  }

  @Input() clase!: Clase;
  archivo?: Archivo;

  onReady(event: any) {
    console.log('Player is ready', event);
    if (event.target.customData && event.target.customData.archivo) {
      this.archivo = event.target.customData.archivo;
      this.obtenerProgresoArchivo();
    }
  }

  onState(event: any) {
    console.log('Player state changed', event);
  }

  onError(event: any) {
    console.error('Error occurred in player', event);
  }

  onProgress(ev: { current: number; duration: number }) {
    this.currentTime = ev.current;
    this.duration = ev.duration;

    if (Math.trunc(this.progressPercent) % 2 == 0 && this.lastSavedPercent != Math.trunc(this.progressPercent)) {
      this.lastSavedPercent = Math.trunc(this.progressPercent);
      console.log('Se guardará el avance en el backend ', this.progressPercent, this.currentTime);

      if (this.progreso) {
        // Actualizar progreso existente
        this.progresoDao.actualizarProgresoArchivo(this.progreso.id!, Math.trunc(this.currentTime), Math.trunc(this.progressPercent)).subscribe({
          next: (res: DefaultResponse | null) => {
            if (res) {
              console.log('Progreso actualizado: ', res);
              //this.progreso = res;
            } else {
              console.error('No se recibió progreso actualizado porque la sesión es nula');
              console.log('Se guardará en local storage: ');
              this.progresoDao.saveProgresoToLocalStorage(this.createProgresoEmpty());
            }
          },
          error: (err: any) => {
            console.error('Error al actualizar el progreso: ', err);
          }
        });
      } else {
        this.progresoDao.guardarProgresoArchivo(this.createProgresoEmpty()).subscribe({
          next: (res: DefaultResponse | null) => {
            if (res) {
              console.log('Progreso guardado: ', res);
            } else {
              console.error('No se recibió progreso actualizado porque la sesión es nula');
              console.log('Se guardará en local storage: ');
              this.progresoDao.saveProgresoToLocalStorage(this.createProgresoEmpty());
            }
          },
          error: (err: any) => {
            console.error('Error al guardar el progreso: ', err);
          }
        });
      }
    }

  }

  get progressPercent(): number {
    return this.duration ? (this.currentTime / this.duration) * 100 : 0;
  }

  private obtenerProgresoArchivo() {
    console.log('Obteniendo progreso para curso: ' + this.clase.curso_id + ', clase: ' + this.clase.id + ', archivo: ' + this.archivo?.id);
    this.progresoDao.obtenerProgresoArchivoByTraza(this.clase.curso_id!, this.clase.id!, this.archivo!.id!).subscribe({
      next: (res) => {
        if (res && res.data && res.data.length > 0) {
          this.progreso = res.data[0];
          console.log('Progreso obtenido: ', this.progreso);
        } else {
          this.progreso = null;
          console.log('No hay progreso previo');
          console.log('Se buscará en local storage: ');
          const progresoLocal = this.progresoDao.getProgresosFromLocalStorage(this.archivo!.id!, this.clase.id!, this.clase.curso_id!);
          if (progresoLocal) {
            console.log('Progreso encontrado en local storage: ', progresoLocal);
            this.progreso = progresoLocal;
            this.currentTime = progresoLocal.avance!;
            console.log('Se ajusta el currentTime a: ', this.currentTime);
          } else {
            console.log('No hay progreso en local storage');
            this.progreso = null;
          }
        }
      },
      error: (err) => {
        console.error('Error al obtener el progreso: ', err);
        this.progreso = null;
      }
    });
  }

  private createProgresoEmpty(): Progreso {
    return {
      id: 0,
      persona_id: 0,
      curso_id: this.clase.curso_id,
      clase_id: this.clase.id,
      archivo_id: this.archivo?.id,
      avance: Math.trunc(this.currentTime),
      porcentaje: Math.trunc(this.progressPercent)
    }
  }

}
