import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { IAppUser } from 'app/entities/app-user/app-user.model';
import { AppUserService } from 'app/entities/app-user/service/app-user.service';
import { PointsService } from '../service/points.service';
import { IPoints } from '../points.model';
import { PointsFormService } from './points-form.service';

import { PointsUpdateComponent } from './points-update.component';

describe('Points Management Update Component', () => {
  let comp: PointsUpdateComponent;
  let fixture: ComponentFixture<PointsUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let pointsFormService: PointsFormService;
  let pointsService: PointsService;
  let appUserService: AppUserService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), PointsUpdateComponent],
      providers: [
        FormBuilder,
        {
          provide: ActivatedRoute,
          useValue: {
            params: from([{}]),
          },
        },
      ],
    })
      .overrideTemplate(PointsUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(PointsUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    pointsFormService = TestBed.inject(PointsFormService);
    pointsService = TestBed.inject(PointsService);
    appUserService = TestBed.inject(AppUserService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call AppUser query and add missing value', () => {
      const points: IPoints = { id: 456 };
      const appUser: IAppUser = { id: 1465 };
      points.appUser = appUser;

      const appUserCollection: IAppUser[] = [{ id: 14228 }];
      jest.spyOn(appUserService, 'query').mockReturnValue(of(new HttpResponse({ body: appUserCollection })));
      const additionalAppUsers = [appUser];
      const expectedCollection: IAppUser[] = [...additionalAppUsers, ...appUserCollection];
      jest.spyOn(appUserService, 'addAppUserToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ points });
      comp.ngOnInit();

      expect(appUserService.query).toHaveBeenCalled();
      expect(appUserService.addAppUserToCollectionIfMissing).toHaveBeenCalledWith(
        appUserCollection,
        ...additionalAppUsers.map(expect.objectContaining),
      );
      expect(comp.appUsersSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const points: IPoints = { id: 456 };
      const appUser: IAppUser = { id: 11796 };
      points.appUser = appUser;

      activatedRoute.data = of({ points });
      comp.ngOnInit();

      expect(comp.appUsersSharedCollection).toContain(appUser);
      expect(comp.points).toEqual(points);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPoints>>();
      const points = { id: 123 };
      jest.spyOn(pointsFormService, 'getPoints').mockReturnValue(points);
      jest.spyOn(pointsService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ points });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: points }));
      saveSubject.complete();

      // THEN
      expect(pointsFormService.getPoints).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(pointsService.update).toHaveBeenCalledWith(expect.objectContaining(points));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPoints>>();
      const points = { id: 123 };
      jest.spyOn(pointsFormService, 'getPoints').mockReturnValue({ id: null });
      jest.spyOn(pointsService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ points: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: points }));
      saveSubject.complete();

      // THEN
      expect(pointsFormService.getPoints).toHaveBeenCalled();
      expect(pointsService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IPoints>>();
      const points = { id: 123 };
      jest.spyOn(pointsService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ points });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(pointsService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareAppUser', () => {
      it('Should forward to appUserService', () => {
        const entity = { id: 123 };
        const entity2 = { id: 456 };
        jest.spyOn(appUserService, 'compareAppUser');
        comp.compareAppUser(entity, entity2);
        expect(appUserService.compareAppUser).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
