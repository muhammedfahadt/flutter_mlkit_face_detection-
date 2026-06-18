import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { ViolationDetailComponent } from './violation-detail.component';

describe('Violation Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ViolationDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: ViolationDetailComponent,
              resolve: { violation: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(ViolationDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load violation on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', ViolationDetailComponent);

      // THEN
      expect(instance.violation).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
