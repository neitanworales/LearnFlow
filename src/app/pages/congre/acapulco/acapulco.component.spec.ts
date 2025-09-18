import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AcapulcoComponent } from './acapulco.component';

describe('AcapulcoComponent', () => {
  let component: AcapulcoComponent;
  let fixture: ComponentFixture<AcapulcoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AcapulcoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AcapulcoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
