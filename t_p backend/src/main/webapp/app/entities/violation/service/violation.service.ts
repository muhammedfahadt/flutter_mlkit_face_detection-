import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IViolation, NewViolation } from '../violation.model';

export type PartialUpdateViolation = Partial<IViolation> & Pick<IViolation, 'id'>;

export type EntityResponseType = HttpResponse<IViolation>;
export type EntityArrayResponseType = HttpResponse<IViolation[]>;

@Injectable({ providedIn: 'root' })
export class ViolationService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/violations');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(violation: NewViolation): Observable<EntityResponseType> {
    return this.http.post<IViolation>(this.resourceUrl, violation, { observe: 'response' });
  }

  update(violation: IViolation): Observable<EntityResponseType> {
    return this.http.put<IViolation>(`${this.resourceUrl}/${this.getViolationIdentifier(violation)}`, violation, { observe: 'response' });
  }

  partialUpdate(violation: PartialUpdateViolation): Observable<EntityResponseType> {
    return this.http.patch<IViolation>(`${this.resourceUrl}/${this.getViolationIdentifier(violation)}`, violation, { observe: 'response' });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IViolation>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IViolation[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getViolationIdentifier(violation: Pick<IViolation, 'id'>): number {
    return violation.id;
  }

  compareViolation(o1: Pick<IViolation, 'id'> | null, o2: Pick<IViolation, 'id'> | null): boolean {
    return o1 && o2 ? this.getViolationIdentifier(o1) === this.getViolationIdentifier(o2) : o1 === o2;
  }

  addViolationToCollectionIfMissing<Type extends Pick<IViolation, 'id'>>(
    violationCollection: Type[],
    ...violationsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const violations: Type[] = violationsToCheck.filter(isPresent);
    if (violations.length > 0) {
      const violationCollectionIdentifiers = violationCollection.map(violationItem => this.getViolationIdentifier(violationItem)!);
      const violationsToAdd = violations.filter(violationItem => {
        const violationIdentifier = this.getViolationIdentifier(violationItem);
        if (violationCollectionIdentifiers.includes(violationIdentifier)) {
          return false;
        }
        violationCollectionIdentifiers.push(violationIdentifier);
        return true;
      });
      return [...violationsToAdd, ...violationCollection];
    }
    return violationCollection;
  }
}
