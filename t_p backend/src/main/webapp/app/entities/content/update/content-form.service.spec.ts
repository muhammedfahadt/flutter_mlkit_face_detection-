import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../content.test-samples';

import { ContentFormService } from './content-form.service';

describe('Content Form Service', () => {
  let service: ContentFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ContentFormService);
  });

  describe('Service methods', () => {
    describe('createContentFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createContentFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            contentType: expect.any(Object),
            uploadDateTime: expect.any(Object),
            status: expect.any(Object),
            appUser: expect.any(Object),
          }),
        );
      });

      it('passing IContent should create a new form with FormGroup', () => {
        const formGroup = service.createContentFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            contentType: expect.any(Object),
            uploadDateTime: expect.any(Object),
            status: expect.any(Object),
            appUser: expect.any(Object),
          }),
        );
      });
    });

    describe('getContent', () => {
      it('should return NewContent for default Content initial value', () => {
        const formGroup = service.createContentFormGroup(sampleWithNewData);

        const content = service.getContent(formGroup) as any;

        expect(content).toMatchObject(sampleWithNewData);
      });

      it('should return NewContent for empty Content initial value', () => {
        const formGroup = service.createContentFormGroup();

        const content = service.getContent(formGroup) as any;

        expect(content).toMatchObject({});
      });

      it('should return IContent', () => {
        const formGroup = service.createContentFormGroup(sampleWithRequiredData);

        const content = service.getContent(formGroup) as any;

        expect(content).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IContent should not enable id FormControl', () => {
        const formGroup = service.createContentFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewContent should disable id FormControl', () => {
        const formGroup = service.createContentFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
