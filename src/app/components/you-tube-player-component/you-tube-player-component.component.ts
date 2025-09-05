import { Component, ElementRef, EventEmitter, Input, NgZone, OnChanges, OnDestroy, OnInit, Output, SimpleChanges, ViewChild } from '@angular/core';
import { YoutubeApiServiceService as YoutubeApiService } from '../../youtube-api-service.service';
import { YT } from 'youtube-iframe';

@Component({
  selector: 'app-you-tube-player-component',
  imports: [],
  templateUrl: './you-tube-player-component.component.html',
  styleUrl: './you-tube-player-component.component.scss'
})
export class YouTubePlayerComponentComponent implements OnInit, OnChanges, OnDestroy {
  @ViewChild('host', { static: true }) host!: ElementRef<HTMLDivElement>;

  @Input() videoId!: string;           // ej. 'dQw4w9WgXcQ'
  @Input() width?: number;             // opcional
  @Input() height?: number;            // opcional
  @Input() start?: number;             // segundos
  @Input() autoplay: 0 | 1 = 0;
  @Input() controls: 0 | 1 = 1;
  @Input() mute: 0 | 1 = 0;
  @Input() loop: 0 | 1 = 0;
  @Input() modestBranding: 0 | 1 = 1;
  @Input() playsinline: 0 | 1 = 1;
  @Input() rel: 0 | 1 = 0;             // no sugerir videos relacionados

  @Output() ready = new EventEmitter<YT.PlayerEvent>();
  @Output() stateChange = new EventEmitter<YT.OnStateChangeEvent>();
  @Output() error = new EventEmitter<YT.OnErrorEvent>();

  private player?: YT.Player;

  constructor(
    private api: YoutubeApiService,
    private zone: NgZone
  ) { }

  async ngOnInit() {
    await this.api.loadApi();
    await this.createPlayer();
  }

  ngOnChanges(changes: SimpleChanges) {
    if (!this.player) return;

    if (changes['videoId'] && !changes['videoId'].firstChange) {
      this.player.cueVideoById({ videoId: this.videoId, startSeconds: this.start });
    }
  }

  ngOnDestroy() {
    this.player?.destroy();
  }

  private async createPlayer() {
    // Evita disparar CD en cada evento del reproductor
    this.zone.runOutsideAngular(() => {
      this.player = new YT.Player(this.host.nativeElement, {
        width: this.width,
        height: this.height,
        videoId: this.videoId,
        playerVars: {
          start: this.start,
          autoplay: this.autoplay,
          controls: this.controls,
          mute: this.mute,
          loop: this.loop,
          modestbranding: this.modestBranding,
          playsinline: this.playsinline,
          rel: this.rel,
          // Para loop con un solo video
          ...(this.loop ? { playlist: this.videoId } : {})
        },
        events: {
          onReady: (e: any) => this.zone.run(() => this.ready.emit(e)),
          onStateChange: (e: any) => this.zone.run(() => this.stateChange.emit(e)),
          onError: (e: any) => this.zone.run(() => this.error.emit(e)),
        }
      });
    });
  }

  // Métodos públicos útiles
  play() { this.player?.playVideo(); }
  pause() { this.player?.pauseVideo(); }
  stop() { this.player?.stopVideo(); }
  seek(sec: number) { this.player?.seekTo(sec, true); }
  muteIt() { this.player?.mute(); }
  unmuteIt() { this.player?.unMute(); }
}