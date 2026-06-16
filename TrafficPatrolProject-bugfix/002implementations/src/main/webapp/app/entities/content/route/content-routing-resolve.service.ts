import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IContent } from '../content.model';
import { ContentService } from '../service/content.service';

export const contentResolve = (route: ActivatedRouteSnapshot): Observable<null | IContent> => {
  const id = route.params['id'];
  if (id) {
    return inject(ContentService)
      .find(id)
      .pipe(
        mergeMap((content: HttpResponse<IContent>) => {
          if (content.body) {
            return of(content.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default contentResolve;
