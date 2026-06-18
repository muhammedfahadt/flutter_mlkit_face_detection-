import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IViolation } from '../violation.model';
import { ViolationService } from '../service/violation.service';

export const violationResolve = (route: ActivatedRouteSnapshot): Observable<null | IViolation> => {
  const id = route.params['id'];
  if (id) {
    return inject(ViolationService)
      .find(id)
      .pipe(
        mergeMap((violation: HttpResponse<IViolation>) => {
          if (violation.body) {
            return of(violation.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default violationResolve;
