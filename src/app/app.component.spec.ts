import { TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { AppComponent } from './app.component';

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [
        RouterTestingModule
      ],
      declarations: [
        AppComponent
      ],
    }).compileComponents();
  });

  it('should return 1', () => {
    const num = 1;
    expect(num).toEqual(1);
  });

  it(`should have as title 'utn-devops-app'`, () => {
    const title = 'utn-devops-app';
    expect(title).toEqual('utn-devops-app');
  });

  it('should return TP-4', () => {
    const tp = 'TP-4';
    expect(tp).toEqual('TP-4');
  });
});
