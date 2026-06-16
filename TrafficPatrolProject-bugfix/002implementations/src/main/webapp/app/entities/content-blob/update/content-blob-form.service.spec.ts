import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../content-blob.test-samples';

import { ContentBlobFormService } from './content-blob-form.service';

describe('ContentBlob Form Service', () => {
  let service: ContentBlobFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ContentBlobFormService);
  });

  describe('Service methods', () => {
    describe('createContentBlobFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createContentBlobFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            contentBlob: expect.any(Object),
            content: expect.any(Object),
          }),
        );
      });

      it('passing IContentBlob should create a new form with FormGroup', () => {
        const formGroup = service.createContentBlobFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            contentBlob: expect.any(Object),
            content: expect.any(Object),
          }),
        );
      });
    });

    describe('getContentBlob', () => {
      it('should return NewContentBlob for default ContentBlob initial value', () => {
        const formGroup = service.createContentBlobFormGroup(sampleWithNewData);

        const contentBlob = service.getContentBlob(formGroup) as any;

        expect(contentBlob).toMatchObject(sampleWithNewData);
      });

      it('should return NewContentBlob for empty ContentBlob initial value', () => {
        const formGroup = service.createContentBlobFormGroup();

        const contentBlob = service.getContentBlob(formGroup) as any;

        expect(contentBlob).toMatchObject({});
      });

      it('should return IContentBlob', () => {
        const formGroup = service.createContentBlobFormGroup(sampleWithRequiredData);

        const contentBlob = service.getContentBlob(formGroup) as any;

        expect(contentBlob).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IContentBlob should not enable id FormControl', () => {
        const formGroup = service.createContentBlobFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewContentBlob should disable id FormControl', () => {
        const formGroup = service.createContentBlobFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
