import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { AppUserComponent } from './list/app-user.component';
import { AppUserDetailComponent } from './detail/app-user-detail.component';
import { AppUserUpdateComponent } from './update/app-user-update.component';
import AppUserResolve from './route/app-user-routing-resolve.service';

const appUserRoute: Routes = [
  {
    path: '',
    component: AppUserComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: AppUserDetailComponent,
    resolve: {
      appUser: AppUserResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: AppUserUpdateComponent,
    resolve: {
      appUser: AppUserResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: AppUserUpdateComponent,
    resolve: {
      appUser: AppUserResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default appUserRoute;
