import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { AppUserDetailComponent } from './app-user-detail.component';

describe('AppUser Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppUserDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: AppUserDetailComponent,
              resolve: { appUser: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(AppUserDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load appUser on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', AppUserDetailComponent);

      // THEN
      expect(instance.appUser).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
