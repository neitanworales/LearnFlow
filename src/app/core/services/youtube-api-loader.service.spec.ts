import { TestBed } from '@angular/core/testing';

import { YoutubeApiLoaderService } from './youtube-api-loader.service';

describe('YoutubeApiLoaderService', () => {
  let service: YoutubeApiLoaderService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(YoutubeApiLoaderService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
