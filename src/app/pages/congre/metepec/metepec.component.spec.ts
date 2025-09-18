import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MetepecComponent } from './metepec.component';

describe('MetepecComponent', () => {
  let component: MetepecComponent;
  let fixture: ComponentFixture<MetepecComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MetepecComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MetepecComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
