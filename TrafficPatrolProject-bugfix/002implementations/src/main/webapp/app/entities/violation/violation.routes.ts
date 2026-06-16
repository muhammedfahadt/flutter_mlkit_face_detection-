import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { ViolationComponent } from './list/violation.component';
import { ViolationDetailComponent } from './detail/violation-detail.component';
import { ViolationUpdateComponent } from './update/violation-update.component';
import ViolationResolve from './route/violation-routing-resolve.service';

const violationRoute: Routes = [
  {
    path: '',
    component: ViolationComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: ViolationDetailComponent,
    resolve: {
      violation: ViolationResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: ViolationUpdateComponent,
    resolve: {
      violation: ViolationResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: ViolationUpdateComponent,
    resolve: {
      violation: ViolationResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default violationRoute;
