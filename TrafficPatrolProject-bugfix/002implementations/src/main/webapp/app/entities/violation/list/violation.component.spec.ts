import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpHeaders, HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { ViolationService } from '../service/violation.service';

import { ViolationComponent } from './violation.component';

describe('Violation Management Component', () => {
  let comp: ViolationComponent;
  let fixture: ComponentFixture<ViolationComponent>;
  let service: ViolationService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
        RouterTestingModule.withRoutes([{ path: 'violation', component: ViolationComponent }]),
        HttpClientTestingModule,
        ViolationComponent,
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
      .overrideTemplate(ViolationComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ViolationComponent);
    comp = fixture.componentInstance;
    service = TestBed.inject(ViolationService);

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
    expect(comp.violations?.[0]).toEqual(expect.objectContaining({ id: 123 }));
  });

  describe('trackId', () => {
    it('Should forward to violationService', () => {
      const entity = { id: 123 };
      jest.spyOn(service, 'getViolationIdentifier');
      const id = comp.trackId(0, entity);
      expect(service.getViolationIdentifier).toHaveBeenCalledWith(entity);
      expect(id).toBe(entity.id);
    });
  });
});
