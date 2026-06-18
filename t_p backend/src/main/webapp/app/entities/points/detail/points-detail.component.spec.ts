import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { PointsDetailComponent } from './points-detail.component';

describe('Points Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PointsDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: PointsDetailComponent,
              resolve: { points: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(PointsDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load points on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', PointsDetailComponent);

      // THEN
      expect(instance.points).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
