import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { map } from 'rxjs/operators';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IContent, NewContent } from '../content.model';

export type PartialUpdateContent = Partial<IContent> & Pick<IContent, 'id'>;

type RestOf<T extends IContent | NewContent> = Omit<T, 'uploadDateTime'> & {
  uploadDateTime?: string | null;
};

export type RestContent = RestOf<IContent>;

export type NewRestContent = RestOf<NewContent>;

export type PartialUpdateRestContent = RestOf<PartialUpdateContent>;

export type EntityResponseType = HttpResponse<IContent>;
export type EntityArrayResponseType = HttpResponse<IContent[]>;

@Injectable({ providedIn: 'root' })
export class ContentService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/contents');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(content: NewContent): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(content);
    return this.http
      .post<RestContent>(this.resourceUrl, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(content: IContent): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(content);
    return this.http
      .put<RestContent>(`${this.resourceUrl}/${this.getContentIdentifier(content)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(content: PartialUpdateContent): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(content);
    return this.http
      .patch<RestContent>(`${this.resourceUrl}/${this.getContentIdentifier(content)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestContent>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestContent[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getContentIdentifier(content: Pick<IContent, 'id'>): number {
    return content.id;
  }

  compareContent(o1: Pick<IContent, 'id'> | null, o2: Pick<IContent, 'id'> | null): boolean {
    return o1 && o2 ? this.getContentIdentifier(o1) === this.getContentIdentifier(o2) : o1 === o2;
  }

  addContentToCollectionIfMissing<Type extends Pick<IContent, 'id'>>(
    contentCollection: Type[],
    ...contentsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const contents: Type[] = contentsToCheck.filter(isPresent);
    if (contents.length > 0) {
      const contentCollectionIdentifiers = contentCollection.map(contentItem => this.getContentIdentifier(contentItem)!);
      const contentsToAdd = contents.filter(contentItem => {
        const contentIdentifier = this.getContentIdentifier(contentItem);
        if (contentCollectionIdentifiers.includes(contentIdentifier)) {
          return false;
        }
        contentCollectionIdentifiers.push(contentIdentifier);
        return true;
      });
      return [...contentsToAdd, ...contentCollection];
    }
    return contentCollection;
  }

  protected convertDateFromClient<T extends IContent | NewContent | PartialUpdateContent>(content: T): RestOf<T> {
    return {
      ...content,
      uploadDateTime: content.uploadDateTime?.toJSON() ?? null,
    };
  }

  protected convertDateFromServer(restContent: RestContent): IContent {
    return {
      ...restContent,
      uploadDateTime: restContent.uploadDateTime ? dayjs(restContent.uploadDateTime) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestContent>): HttpResponse<IContent> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestContent[]>): HttpResponse<IContent[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }
}
