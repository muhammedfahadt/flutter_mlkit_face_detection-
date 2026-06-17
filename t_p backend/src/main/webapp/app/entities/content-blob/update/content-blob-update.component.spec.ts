import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { IContent } from 'app/entities/content/content.model';
import { ContentService } from 'app/entities/content/service/content.service';
import { ContentBlobService } from '../service/content-blob.service';
import { IContentBlob } from '../content-blob.model';
import { ContentBlobFormService } from './content-blob-form.service';

import { ContentBlobUpdateComponent } from './content-blob-update.component';

describe('ContentBlob Management Update Component', () => {
  let comp: ContentBlobUpdateComponent;
  let fixture: ComponentFixture<ContentBlobUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let contentBlobFormService: ContentBlobFormService;
  let contentBlobService: ContentBlobService;
  let contentService: ContentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), ContentBlobUpdateComponent],
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
      .overrideTemplate(ContentBlobUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ContentBlobUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    contentBlobFormService = TestBed.inject(ContentBlobFormService);
    contentBlobService = TestBed.inject(ContentBlobService);
    contentService = TestBed.inject(ContentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call Content query and add missing value', () => {
      const contentBlob: IContentBlob = { id: 456 };
      const content: IContent = { id: 21554 };
      contentBlob.content = content;

      const contentCollection: IContent[] = [{ id: 25735 }];
      jest.spyOn(contentService, 'query').mockReturnValue(of(new HttpResponse({ body: contentCollection })));
      const additionalContents = [content];
      const expectedCollection: IContent[] = [...additionalContents, ...contentCollection];
      jest.spyOn(contentService, 'addContentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ contentBlob });
      comp.ngOnInit();

      expect(contentService.query).toHaveBeenCalled();
      expect(contentService.addContentToCollectionIfMissing).toHaveBeenCalledWith(
        contentCollection,
        ...additionalContents.map(expect.objectContaining),
      );
      expect(comp.contentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const contentBlob: IContentBlob = { id: 456 };
      const content: IContent = { id: 29022 };
      contentBlob.content = content;

      activatedRoute.data = of({ contentBlob });
      comp.ngOnInit();

      expect(comp.contentsSharedCollection).toContain(content);
      expect(comp.contentBlob).toEqual(contentBlob);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IContentBlob>>();
      const contentBlob = { id: 123 };
      jest.spyOn(contentBlobFormService, 'getContentBlob').mockReturnValue(contentBlob);
      jest.spyOn(contentBlobService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ contentBlob });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: contentBlob }));
      saveSubject.complete();

      // THEN
      expect(contentBlobFormService.getContentBlob).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(contentBlobService.update).toHaveBeenCalledWith(expect.objectContaining(contentBlob));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IContentBlob>>();
      const contentBlob = { id: 123 };
      jest.spyOn(contentBlobFormService, 'getContentBlob').mockReturnValue({ id: null });
      jest.spyOn(contentBlobService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ contentBlob: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: contentBlob }));
      saveSubject.complete();

      // THEN
      expect(contentBlobFormService.getContentBlob).toHaveBeenCalled();
      expect(contentBlobService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IContentBlob>>();
      const contentBlob = { id: 123 };
      jest.spyOn(contentBlobService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ contentBlob });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(contentBlobService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
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
