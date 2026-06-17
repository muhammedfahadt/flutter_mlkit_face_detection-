import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { ContentComponent } from './list/content.component';
import { ContentDetailComponent } from './detail/content-detail.component';
import { ContentUpdateComponent } from './update/content-update.component';
import ContentResolve from './route/content-routing-resolve.service';

const contentRoute: Routes = [
  {
    path: '',
    component: ContentComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: ContentDetailComponent,
    resolve: {
      content: ContentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: ContentUpdateComponent,
    resolve: {
      content: ContentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: ContentUpdateComponent,
    resolve: {
      content: ContentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default contentRoute;
