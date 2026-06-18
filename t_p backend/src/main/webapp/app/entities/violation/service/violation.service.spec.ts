import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IViolation } from '../violation.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../violation.test-samples';

import { ViolationService } from './violation.service';

const requireRestSample: IViolation = {
  ...sampleWithRequiredData,
};

describe('Violation Service', () => {
  let service: ViolationService;
  let httpMock: HttpTestingController;
  let expectedResult: IViolation | IViolation[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(ViolationService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  describe('Service methods', () => {
    it('should find an element', () => {
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.find(123).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should create a Violation', () => {
      const violation = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(violation).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a Violation', () => {
      const violation = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(violation).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a Violation', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of Violation', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a Violation', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addViolationToCollectionIfMissing', () => {
      it('should add a Violation to an empty array', () => {
        const violation: IViolation = sampleWithRequiredData;
        expectedResult = service.addViolationToCollectionIfMissing([], violation);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(violation);
      });

      it('should not add a Violation to an array that contains it', () => {
        const violation: IViolation = sampleWithRequiredData;
        const violationCollection: IViolation[] = [
          {
            ...violation,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addViolationToCollectionIfMissing(violationCollection, violation);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a Violation to an array that doesn't contain it", () => {
        const violation: IViolation = sampleWithRequiredData;
        const violationCollection: IViolation[] = [sampleWithPartialData];
        expectedResult = service.addViolationToCollectionIfMissing(violationCollection, violation);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(violation);
      });

      it('should add only unique Violation to an array', () => {
        const violationArray: IViolation[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const violationCollection: IViolation[] = [sampleWithRequiredData];
        expectedResult = service.addViolationToCollectionIfMissing(violationCollection, ...violationArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const violation: IViolation = sampleWithRequiredData;
        const violation2: IViolation = sampleWithPartialData;
        expectedResult = service.addViolationToCollectionIfMissing([], violation, violation2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(violation);
        expect(expectedResult).toContain(violation2);
      });

      it('should accept null and undefined values', () => {
        const violation: IViolation = sampleWithRequiredData;
        expectedResult = service.addViolationToCollectionIfMissing([], null, violation, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(violation);
      });

      it('should return initial array if no Violation is added', () => {
        const violationCollection: IViolation[] = [sampleWithRequiredData];
        expectedResult = service.addViolationToCollectionIfMissing(violationCollection, undefined, null);
        expect(expectedResult).toEqual(violationCollection);
      });
    });

    describe('compareViolation', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareViolation(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareViolation(entity1, entity2);
        const compareResult2 = service.compareViolation(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareViolation(entity1, entity2);
        const compareResult2 = service.compareViolation(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareViolation(entity1, entity2);
        const compareResult2 = service.compareViolation(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
