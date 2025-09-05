import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecursosClaseComponent } from './recursos-clase.component';

describe('RecursosClaseComponent', () => {
  let component: RecursosClaseComponent;
  let fixture: ComponentFixture<RecursosClaseComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RecursosClaseComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RecursosClaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
