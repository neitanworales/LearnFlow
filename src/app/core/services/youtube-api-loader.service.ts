import { Inject, Injectable } from '@angular/core';
import { DOCUMENT } from '@angular/common';

// Declare YT type for TypeScript
declare global {
  interface Window {
    YT: any;
    onYouTubeIframeAPIReady: () => void;
  }
}
type YT = typeof window.YT;


@Injectable({ providedIn: 'root' })
export class YoutubeApiLoaderService {
  private loadingPromise?: Promise<YT>;

  constructor(@Inject(DOCUMENT) private document: Document) {}

  loadApi(): Promise<YT> {
    if (typeof window !== 'undefined' && (window as any).YT?.Player) {
      console.log("Ya está cargado");
      return Promise.resolve(window.YT);
    }

    if (!this.loadingPromise) {
      this.loadingPromise = new Promise<YT>((resolve) => {
        const scriptId = 'youtube-iframe-api';
        if (!this.document.getElementById(scriptId)) {
          const tag = this.document.createElement('script');
          tag.id = scriptId;
          tag.src = 'https://www.youtube.com/iframe_api';
          this.document.body.appendChild(tag);
        }

        // El API llama a esta función cuando está listo
        (window as any).onYouTubeIframeAPIReady = () => {
          resolve(window.YT);
        };
      });
    }

    return this.loadingPromise;
  }
}