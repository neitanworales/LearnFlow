import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeclaracionFeComponent } from './declaracion-fe.component';

describe('DeclaracionFeComponent', () => {
  let component: DeclaracionFeComponent;
  let fixture: ComponentFixture<DeclaracionFeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DeclaracionFeComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DeclaracionFeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
