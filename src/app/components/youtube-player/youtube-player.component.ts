import {
  AfterViewInit,
  Component,
  ElementRef,
  EventEmitter,
  Input,
  OnDestroy,
  Output,
  ViewChild,
} from '@angular/core';
import { Utils } from 'src/app/core/api/Utils';
import { Archivo } from 'src/app/core/model/escuela/Archivo';
import { Progreso } from 'src/app/core/model/escuela/Progreso';
import { YoutubeApiLoaderService } from 'src/app/core/services/youtube-api-loader.service';

declare global {
  interface Window {
    YT: any;
    onYouTubeIframeAPIReady: () => void;
  }
}
type YT = typeof window.YT;

@Component({
  selector: 'app-youtube-player',
  imports: [],
  templateUrl: './youtube-player.component.html',
  styleUrl: './youtube-player.component.scss'
})
export class YoutubePlayerComponent implements AfterViewInit, OnDestroy {
  @ViewChild('container', { static: true }) container!: ElementRef<HTMLDivElement>;

  /** ID del video (e.g., "dQw4w9WgXcQ") */
  @Input() videoId!: string;
  @Input() width?: string;
  @Input() height?: number;
  @Input() archivo?: Archivo;
  @Input() progreso?: Progreso;

  private progressInterval?: any;

  /** Opciones playerVars de YT (autoplay, controls, start, etc.) */
  @Input() playerVars: {
    autoplay?: number;
    controls?: number;
    rel?: number;
    modestbranding?: number;
    playsinline?: number;
    [key: string]: any;
  } = {
      autoplay: 0,
      controls: 1,
      rel: 0,
      modestbranding: 1,
      playsinline: 1,
    };

  /** Eventos útiles */
  @Output() ready = new EventEmitter<any>();
  @Output() stateChange = new EventEmitter<any>();
  @Output() error = new EventEmitter<any>();
  @Output() progress = new EventEmitter<{ current: number; duration: number }>();

  private player?: any;
  hasAppliedStartAt: boolean = false;

  constructor(
    private ytLoader: YoutubeApiLoaderService
  ) { }

  async ngAfterViewInit() {
    const YTapi = await this.ytLoader.loadApi();
    this.player = new YTapi.Player(this.container.nativeElement, {
      width: this.width,
      height: this.height,
      //videoId: this.videoId,
      playerVars: this.playerVars,
      events: {
        onReady: (ev: any) => {
          ev.target.customData = { archivo: this.archivo, progreso: this.progreso };
          this.ready.emit(ev);
          // Carga inicial controlada:
          if (this.progreso?.avance! > 0) {
            // Si quieres que arranque automáticamente desde startAt:
            // ev.target.loadVideoById({ videoId: this.videoId, startSeconds: this.startAt });
            // Si prefieres que quede listo y espere al play:
            ev.target.cueVideoById({ videoId: this.videoId, startSeconds: this.progreso?.avance! });
            this.hasAppliedStartAt = true; // ya aplicamos
          } else {
            ev.target.cueVideoById(this.videoId);
          }
          this.startTracking();
        },
        onStateChange: (ev: any) => {

          this.stateChange.emit(ev);

          // Si el startAt llega TARDE (después de onReady), aplícalo al entrar en CUED.
          if (ev.data === YTapi.PlayerState.CUED && this.progreso?.avance! > 0 && !this.hasAppliedStartAt) {
            // Mueve el puntero SIN reproducir (espera que el usuario presione play)
            ev.target.seekTo(this.progreso?.avance!, true);
            this.hasAppliedStartAt = true;
          } else if (ev.data === YTapi.PlayerState.PLAYING) {
            this.startTracking();
          } else if (ev.data === YTapi.PlayerState.PAUSED || ev.data === YTapi.PlayerState.ENDED) {
            this.stopTracking();
          }
        },
        onError: (ev: any) => this.error.emit(ev),
      },
    });
  }

  private startTracking() {
    if (this.progressInterval) return;
    this.progressInterval = setInterval(() => {
      if (this.player) {
        const current = this.player.getCurrentTime();
        const duration = this.player.getDuration();
        this.progress.emit({ current, duration });
        if (this.archivo!.duracion == null || this.archivo!.duracion === undefined || this.archivo!.duracion === '00:00:00') {
          this.archivo!.duracion = duration;
        }
      }
    }, 500); // cada medio segundo
  }

  private stopTracking() {
    clearInterval(this.progressInterval);
    this.progressInterval = undefined;
  }

  ngOnDestroy() {
    this.stopTracking();
    try { this.player?.destroy(); } catch { }
  }

  // Métodos públicos para controlar el player desde afuera
  play() { this.player?.playVideo(); }
  pause() { this.player?.pauseVideo(); }
  stop() { this.player?.stopVideo(); }
  seek(seconds: number) { this.player?.seekTo(seconds, true); }
  mute() { this.player?.mute(); }
  unMute() { this.player?.unMute(); }
  setVolume(v: number) { this.player?.setVolume(v); }
  get playerInstance() { return this.player; }
}