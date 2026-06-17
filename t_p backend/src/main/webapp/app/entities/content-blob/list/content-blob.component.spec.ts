import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpHeaders, HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { ContentBlobService } from '../service/content-blob.service';

import { ContentBlobComponent } from './content-blob.component';

describe('ContentBlob Management Component', () => {
  let comp: ContentBlobComponent;
  let fixture: ComponentFixture<ContentBlobComponent>;
  let service: ContentBlobService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
        RouterTestingModule.withRoutes([{ path: 'content-blob', component: ContentBlobComponent }]),
        HttpClientTestingModule,
        ContentBlobComponent,
      ],
      providers: [
        {
          provide: ActivatedRoute,
          useValue: {
            data: of({
              defaultSort: 'id,asc',
            }),
            queryParamMap: of(
              jest.requireActual('@angular/router').convertToParamMap({
                page: '1',
                size: '1',
                sort: 'id,desc',
              }),
            ),
            snapshot: { queryParams: {} },
          },
        },
      ],
    })
      .overrideTemplate(ContentBlobComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ContentBlobComponent);
    comp = fixture.componentInstance;
    service = TestBed.inject(ContentBlobService);

    const headers = new HttpHeaders();
    jest.spyOn(service, 'query').mockReturnValue(
      of(
        new HttpResponse({
          body: [{ id: 123 }],
          headers,
        }),
      ),
    );
  });

  it('Should call load all on init', () => {
    // WHEN
    comp.ngOnInit();

    // THEN
    expect(service.query).toHaveBeenCalled();
    expect(comp.contentBlobs?.[0]).toEqual(expect.objectContaining({ id: 123 }));
  });

  describe('trackId', () => {
    it('Should forward to contentBlobService', () => {
      const entity = { id: 123 };
      jest.spyOn(service, 'getContentBlobIdentifier');
      const id = comp.trackId(0, entity);
      expect(service.getContentBlobIdentifier).toHaveBeenCalledWith(entity);
      expect(id).toBe(entity.id);
    });
  });
});
