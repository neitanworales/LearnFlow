import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Clase } from 'src/app/core/model/escuela/Clase';
import { VideoPlayerComponent } from '../video-player/video-player.component';

@Component({
  selector: 'app-recursos-clase',
  imports: [CommonModule, VideoPlayerComponent],
  standalone: true,
  templateUrl: './recursos-clase.component.html',
  styleUrl: './recursos-clase.component.scss'
})
export class RecursosClaseComponent implements OnInit {
  
  ngOnInit(): void {
    
  }

  @Input() clase!: Clase;

}
