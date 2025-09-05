import { ComponentFixture, TestBed } from '@angular/core/testing';

import { YouTubePlayerComponentComponent } from './you-tube-player-component.component';

describe('YouTubePlayerComponentComponent', () => {
  let component: YouTubePlayerComponentComponent;
  let fixture: ComponentFixture<YouTubePlayerComponentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [YouTubePlayerComponentComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(YouTubePlayerComponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
