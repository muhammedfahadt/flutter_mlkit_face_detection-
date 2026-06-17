import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IContent } from '../content.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../content.test-samples';

import { ContentService, RestContent } from './content.service';

const requireRestSample: RestContent = {
  ...sampleWithRequiredData,
  uploadDateTime: sampleWithRequiredData.uploadDateTime?.toJSON(),
};

describe('Content Service', () => {
  let service: ContentService;
  let httpMock: HttpTestingController;
  let expectedResult: IContent | IContent[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(ContentService);
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

    it('should create a Content', () => {
      const content = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(content).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a Content', () => {
      const content = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(content).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a Content', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of Content', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a Content', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addContentToCollectionIfMissing', () => {
      it('should add a Content to an empty array', () => {
        const content: IContent = sampleWithRequiredData;
        expectedResult = service.addContentToCollectionIfMissing([], content);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(content);
      });

      it('should not add a Content to an array that contains it', () => {
        const content: IContent = sampleWithRequiredData;
        const contentCollection: IContent[] = [
          {
            ...content,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addContentToCollectionIfMissing(contentCollection, content);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a Content to an array that doesn't contain it", () => {
        const content: IContent = sampleWithRequiredData;
        const contentCollection: IContent[] = [sampleWithPartialData];
        expectedResult = service.addContentToCollectionIfMissing(contentCollection, content);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(content);
      });

      it('should add only unique Content to an array', () => {
        const contentArray: IContent[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const contentCollection: IContent[] = [sampleWithRequiredData];
        expectedResult = service.addContentToCollectionIfMissing(contentCollection, ...contentArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const content: IContent = sampleWithRequiredData;
        const content2: IContent = sampleWithPartialData;
        expectedResult = service.addContentToCollectionIfMissing([], content, content2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(content);
        expect(expectedResult).toContain(content2);
      });

      it('should accept null and undefined values', () => {
        const content: IContent = sampleWithRequiredData;
        expectedResult = service.addContentToCollectionIfMissing([], null, content, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(content);
      });

      it('should return initial array if no Content is added', () => {
        const contentCollection: IContent[] = [sampleWithRequiredData];
        expectedResult = service.addContentToCollectionIfMissing(contentCollection, undefined, null);
        expect(expectedResult).toEqual(contentCollection);
      });
    });

    describe('compareContent', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareContent(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareContent(entity1, entity2);
        const compareResult2 = service.compareContent(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareContent(entity1, entity2);
        const compareResult2 = service.compareContent(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareContent(entity1, entity2);
        const compareResult2 = service.compareContent(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
