import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MiAvanceComponent } from './mi-avance.component';

describe('MiAvanceComponent', () => {
  let component: MiAvanceComponent;
  let fixture: ComponentFixture<MiAvanceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MiAvanceComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MiAvanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
