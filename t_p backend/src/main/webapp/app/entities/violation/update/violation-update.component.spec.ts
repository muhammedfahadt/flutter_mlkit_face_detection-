import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { IPoints } from 'app/entities/points/points.model';
import { PointsService } from 'app/entities/points/service/points.service';
import { IAppUser } from 'app/entities/app-user/app-user.model';
import { AppUserService } from 'app/entities/app-user/service/app-user.service';
import { IContent } from 'app/entities/content/content.model';
import { ContentService } from 'app/entities/content/service/content.service';
import { IViolation } from '../violation.model';
import { ViolationService } from '../service/violation.service';
import { ViolationFormService } from './violation-form.service';

import { ViolationUpdateComponent } from './violation-update.component';

describe('Violation Management Update Component', () => {
  let comp: ViolationUpdateComponent;
  let fixture: ComponentFixture<ViolationUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let violationFormService: ViolationFormService;
  let violationService: ViolationService;
  let pointsService: PointsService;
  let appUserService: AppUserService;
  let contentService: ContentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), ViolationUpdateComponent],
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
      .overrideTemplate(ViolationUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ViolationUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    violationFormService = TestBed.inject(ViolationFormService);
    violationService = TestBed.inject(ViolationService);
    pointsService = TestBed.inject(PointsService);
    appUserService = TestBed.inject(AppUserService);
    contentService = TestBed.inject(ContentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call points query and add missing value', () => {
      const violation: IViolation = { id: 456 };
      const points: IPoints = { id: 26105 };
      violation.points = points;

      const pointsCollection: IPoints[] = [{ id: 29209 }];
      jest.spyOn(pointsService, 'query').mockReturnValue(of(new HttpResponse({ body: pointsCollection })));
      const expectedCollection: IPoints[] = [points, ...pointsCollection];
      jest.spyOn(pointsService, 'addPointsToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ violation });
      comp.ngOnInit();

      expect(pointsService.query).toHaveBeenCalled();
      expect(pointsService.addPointsToCollectionIfMissing).toHaveBeenCalledWith(pointsCollection, points);
      expect(comp.pointsCollection).toEqual(expectedCollection);
    });

    it('Should call AppUser query and add missing value', () => {
      const violation: IViolation = { id: 456 };
      const appUser: IAppUser = { id: 10893 };
      violation.appUser = appUser;

      const appUserCollection: IAppUser[] = [{ id: 29621 }];
      jest.spyOn(appUserService, 'query').mockReturnValue(of(new HttpResponse({ body: appUserCollection })));
      const additionalAppUsers = [appUser];
      const expectedCollection: IAppUser[] = [...additionalAppUsers, ...appUserCollection];
      jest.spyOn(appUserService, 'addAppUserToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ violation });
      comp.ngOnInit();

      expect(appUserService.query).toHaveBeenCalled();
      expect(appUserService.addAppUserToCollectionIfMissing).toHaveBeenCalledWith(
        appUserCollection,
        ...additionalAppUsers.map(expect.objectContaining),
      );
      expect(comp.appUsersSharedCollection).toEqual(expectedCollection);
    });

    it('Should call Content query and add missing value', () => {
      const violation: IViolation = { id: 456 };
      const content: IContent = { id: 6083 };
      violation.content = content;

      const contentCollection: IContent[] = [{ id: 31313 }];
      jest.spyOn(contentService, 'query').mockReturnValue(of(new HttpResponse({ body: contentCollection })));
      const additionalContents = [content];
      const expectedCollection: IContent[] = [...additionalContents, ...contentCollection];
      jest.spyOn(contentService, 'addContentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ violation });
      comp.ngOnInit();

      expect(contentService.query).toHaveBeenCalled();
      expect(contentService.addContentToCollectionIfMissing).toHaveBeenCalledWith(
        contentCollection,
        ...additionalContents.map(expect.objectContaining),
      );
      expect(comp.contentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const violation: IViolation = { id: 456 };
      const points: IPoints = { id: 13830 };
      violation.points = points;
      const appUser: IAppUser = { id: 29088 };
      violation.appUser = appUser;
      const content: IContent = { id: 26578 };
      violation.content = content;

      activatedRoute.data = of({ violation });
      comp.ngOnInit();

      expect(comp.pointsCollection).toContain(points);
      expect(comp.appUsersSharedCollection).toContain(appUser);
      expect(comp.contentsSharedCollection).toContain(content);
      expect(comp.violation).toEqual(violation);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IViolation>>();
      const violation = { id: 123 };
      jest.spyOn(violationFormService, 'getViolation').mockReturnValue(violation);
      jest.spyOn(violationService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ violation });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: violation }));
      saveSubject.complete();

      // THEN
      expect(violationFormService.getViolation).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(violationService.update).toHaveBeenCalledWith(expect.objectContaining(violation));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IViolation>>();
      const violation = { id: 123 };
      jest.spyOn(violationFormService, 'getViolation').mockReturnValue({ id: null });
      jest.spyOn(violationService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ violation: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: violation }));
      saveSubject.complete();

      // THEN
      expect(violationFormService.getViolation).toHaveBeenCalled();
      expect(violationService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IViolation>>();
      const violation = { id: 123 };
      jest.spyOn(violationService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ violation });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(violationService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('comparePoints', () => {
      it('Should forward to pointsService', () => {
        const entity = { id: 123 };
        const entity2 = { id: 456 };
        jest.spyOn(pointsService, 'comparePoints');
        comp.comparePoints(entity, entity2);
        expect(pointsService.comparePoints).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareAppUser', () => {
      it('Should forward to appUserService', () => {
        const entity = { id: 123 };
        const entity2 = { id: 456 };
        jest.spyOn(appUserService, 'compareAppUser');
        comp.compareAppUser(entity, entity2);
        expect(appUserService.compareAppUser).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareContent', () => {
      it('Should forward to contentService', () => {
        const entity = { id: 123 };
        const entity2 = { id: 456 };
        jest.spyOn(contentService, 'compareContent');
        comp.compareContent(entity, entity2);
        expect(contentService.compareContent).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
