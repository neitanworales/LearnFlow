import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VisionMisionObjetivosComponent } from './vision-mision-objetivos.component';

describe('VisionMisionObjetivosComponent', () => {
  let component: VisionMisionObjetivosComponent;
  let fixture: ComponentFixture<VisionMisionObjetivosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VisionMisionObjetivosComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VisionMisionObjetivosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
