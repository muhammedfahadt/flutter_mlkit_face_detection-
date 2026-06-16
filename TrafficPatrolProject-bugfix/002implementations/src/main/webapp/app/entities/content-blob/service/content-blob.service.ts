import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IContentBlob, NewContentBlob } from '../content-blob.model';

export type PartialUpdateContentBlob = Partial<IContentBlob> & Pick<IContentBlob, 'id'>;

export type EntityResponseType = HttpResponse<IContentBlob>;
export type EntityArrayResponseType = HttpResponse<IContentBlob[]>;

@Injectable({ providedIn: 'root' })
export class ContentBlobService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/content-blobs');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(contentBlob: NewContentBlob): Observable<EntityResponseType> {
    return this.http.post<IContentBlob>(this.resourceUrl, contentBlob, { observe: 'response' });
  }

  update(contentBlob: IContentBlob): Observable<EntityResponseType> {
    return this.http.put<IContentBlob>(`${this.resourceUrl}/${this.getContentBlobIdentifier(contentBlob)}`, contentBlob, {
      observe: 'response',
    });
  }

  partialUpdate(contentBlob: PartialUpdateContentBlob): Observable<EntityResponseType> {
    return this.http.patch<IContentBlob>(`${this.resourceUrl}/${this.getContentBlobIdentifier(contentBlob)}`, contentBlob, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IContentBlob>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IContentBlob[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getContentBlobIdentifier(contentBlob: Pick<IContentBlob, 'id'>): number {
    return contentBlob.id;
  }

  compareContentBlob(o1: Pick<IContentBlob, 'id'> | null, o2: Pick<IContentBlob, 'id'> | null): boolean {
    return o1 && o2 ? this.getContentBlobIdentifier(o1) === this.getContentBlobIdentifier(o2) : o1 === o2;
  }

  addContentBlobToCollectionIfMissing<Type extends Pick<IContentBlob, 'id'>>(
    contentBlobCollection: Type[],
    ...contentBlobsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const contentBlobs: Type[] = contentBlobsToCheck.filter(isPresent);
    if (contentBlobs.length > 0) {
      const contentBlobCollectionIdentifiers = contentBlobCollection.map(
        contentBlobItem => this.getContentBlobIdentifier(contentBlobItem)!,
      );
      const contentBlobsToAdd = contentBlobs.filter(contentBlobItem => {
        const contentBlobIdentifier = this.getContentBlobIdentifier(contentBlobItem);
        if (contentBlobCollectionIdentifiers.includes(contentBlobIdentifier)) {
          return false;
        }
        contentBlobCollectionIdentifiers.push(contentBlobIdentifier);
        return true;
      });
      return [...contentBlobsToAdd, ...contentBlobCollection];
    }
    return contentBlobCollection;
  }
}
