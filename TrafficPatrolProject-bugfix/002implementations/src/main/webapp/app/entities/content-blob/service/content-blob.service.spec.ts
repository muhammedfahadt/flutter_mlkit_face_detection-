import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IContentBlob } from '../content-blob.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../content-blob.test-samples';

import { ContentBlobService } from './content-blob.service';

const requireRestSample: IContentBlob = {
  ...sampleWithRequiredData,
};

describe('ContentBlob Service', () => {
  let service: ContentBlobService;
  let httpMock: HttpTestingController;
  let expectedResult: IContentBlob | IContentBlob[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(ContentBlobService);
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

    it('should create a ContentBlob', () => {
      const contentBlob = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(contentBlob).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a ContentBlob', () => {
      const contentBlob = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(contentBlob).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a ContentBlob', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of ContentBlob', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a ContentBlob', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addContentBlobToCollectionIfMissing', () => {
      it('should add a ContentBlob to an empty array', () => {
        const contentBlob: IContentBlob = sampleWithRequiredData;
        expectedResult = service.addContentBlobToCollectionIfMissing([], contentBlob);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(contentBlob);
      });

      it('should not add a ContentBlob to an array that contains it', () => {
        const contentBlob: IContentBlob = sampleWithRequiredData;
        const contentBlobCollection: IContentBlob[] = [
          {
            ...contentBlob,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addContentBlobToCollectionIfMissing(contentBlobCollection, contentBlob);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a ContentBlob to an array that doesn't contain it", () => {
        const contentBlob: IContentBlob = sampleWithRequiredData;
        const contentBlobCollection: IContentBlob[] = [sampleWithPartialData];
        expectedResult = service.addContentBlobToCollectionIfMissing(contentBlobCollection, contentBlob);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(contentBlob);
      });

      it('should add only unique ContentBlob to an array', () => {
        const contentBlobArray: IContentBlob[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const contentBlobCollection: IContentBlob[] = [sampleWithRequiredData];
        expectedResult = service.addContentBlobToCollectionIfMissing(contentBlobCollection, ...contentBlobArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const contentBlob: IContentBlob = sampleWithRequiredData;
        const contentBlob2: IContentBlob = sampleWithPartialData;
        expectedResult = service.addContentBlobToCollectionIfMissing([], contentBlob, contentBlob2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(contentBlob);
        expect(expectedResult).toContain(contentBlob2);
      });

      it('should accept null and undefined values', () => {
        const contentBlob: IContentBlob = sampleWithRequiredData;
        expectedResult = service.addContentBlobToCollectionIfMissing([], null, contentBlob, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(contentBlob);
      });

      it('should return initial array if no ContentBlob is added', () => {
        const contentBlobCollection: IContentBlob[] = [sampleWithRequiredData];
        expectedResult = service.addContentBlobToCollectionIfMissing(contentBlobCollection, undefined, null);
        expect(expectedResult).toEqual(contentBlobCollection);
      });
    });

    describe('compareContentBlob', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareContentBlob(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareContentBlob(entity1, entity2);
        const compareResult2 = service.compareContentBlob(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareContentBlob(entity1, entity2);
        const compareResult2 = service.compareContentBlob(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareContentBlob(entity1, entity2);
        const compareResult2 = service.compareContentBlob(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
