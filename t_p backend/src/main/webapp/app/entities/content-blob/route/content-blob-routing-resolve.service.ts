import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IContentBlob } from '../content-blob.model';
import { ContentBlobService } from '../service/content-blob.service';

export const contentBlobResolve = (route: ActivatedRouteSnapshot): Observable<null | IContentBlob> => {
  const id = route.params['id'];
  if (id) {
    return inject(ContentBlobService)
      .find(id)
      .pipe(
        mergeMap((contentBlob: HttpResponse<IContentBlob>) => {
          if (contentBlob.body) {
            return of(contentBlob.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default contentBlobResolve;
