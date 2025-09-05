import { TestBed } from '@angular/core/testing';

import { YoutubeApiServiceService } from './youtube-api-service.service';

describe('YoutubeApiServiceService', () => {
  let service: YoutubeApiServiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(YoutubeApiServiceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
