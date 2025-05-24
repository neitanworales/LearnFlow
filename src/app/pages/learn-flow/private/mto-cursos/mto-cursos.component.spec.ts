import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MtoCursosComponent } from './mto-cursos.component';

describe('MtoCursosComponent', () => {
  let component: MtoCursosComponent;
  let fixture: ComponentFixture<MtoCursosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MtoCursosComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MtoCursosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
