import { Injectable, NgZone } from '@angular/core';
import { YT } from '@types/youtube';

declare global {
  interface Window {
    onYouTubeIframeAPIReady?: () => void;
    YT: typeof YT;
  }
}

@Injectable({
  providedIn: 'root'
})
export class YoutubeApiServiceService {
  private loading?: Promise<void>;

  constructor(private zone: NgZone) {}

  loadApi(): Promise<void> {
    if (window.YT?.Player) return Promise.resolve();

    if (!this.loading) {
      this.loading = new Promise<void>((resolve) => {
        const scriptId = 'youtube-iframe-api';
        if (!document.getElementById(scriptId)) {
          const tag = document.createElement('script');
          tag.id = scriptId;
          tag.src = 'https://www.youtube.com/iframe_api';
          document.head.appendChild(tag);
        }
        window.onYouTubeIframeAPIReady = () => {
          // Re-entramos a Angular cuando la API esté lista
          this.zone.run(() => resolve());
        };
      });
    }
    return this.loading;
  }
}
