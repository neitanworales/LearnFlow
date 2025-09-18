import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CoyoacanComponent } from './coyoacan.component';

describe('CoyoacanComponent', () => {
  let component: CoyoacanComponent;
  let fixture: ComponentFixture<CoyoacanComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CoyoacanComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CoyoacanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
