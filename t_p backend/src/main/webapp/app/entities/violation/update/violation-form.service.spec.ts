import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../violation.test-samples';

import { ViolationFormService } from './violation-form.service';

describe('Violation Form Service', () => {
  let service: ViolationFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ViolationFormService);
  });

  describe('Service methods', () => {
    describe('createViolationFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createViolationFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            violationType: expect.any(Object),
            points: expect.any(Object),
            appUser: expect.any(Object),
            content: expect.any(Object),
          }),
        );
      });

      it('passing IViolation should create a new form with FormGroup', () => {
        const formGroup = service.createViolationFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            violationType: expect.any(Object),
            points: expect.any(Object),
            appUser: expect.any(Object),
            content: expect.any(Object),
          }),
        );
      });
    });

    describe('getViolation', () => {
      it('should return NewViolation for default Violation initial value', () => {
        const formGroup = service.createViolationFormGroup(sampleWithNewData);

        const violation = service.getViolation(formGroup) as any;

        expect(violation).toMatchObject(sampleWithNewData);
      });

      it('should return NewViolation for empty Violation initial value', () => {
        const formGroup = service.createViolationFormGroup();

        const violation = service.getViolation(formGroup) as any;

        expect(violation).toMatchObject({});
      });

      it('should return IViolation', () => {
        const formGroup = service.createViolationFormGroup(sampleWithRequiredData);

        const violation = service.getViolation(formGroup) as any;

        expect(violation).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IViolation should not enable id FormControl', () => {
        const formGroup = service.createViolationFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewViolation should disable id FormControl', () => {
        const formGroup = service.createViolationFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
