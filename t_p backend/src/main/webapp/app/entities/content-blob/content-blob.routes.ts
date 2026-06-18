import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { ContentBlobComponent } from './list/content-blob.component';
import { ContentBlobDetailComponent } from './detail/content-blob-detail.component';
import { ContentBlobUpdateComponent } from './update/content-blob-update.component';
import ContentBlobResolve from './route/content-blob-routing-resolve.service';

const contentBlobRoute: Routes = [
  {
    path: '',
    component: ContentBlobComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: ContentBlobDetailComponent,
    resolve: {
      contentBlob: ContentBlobResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: ContentBlobUpdateComponent,
    resolve: {
      contentBlob: ContentBlobResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: ContentBlobUpdateComponent,
    resolve: {
      contentBlob: ContentBlobResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default contentBlobRoute;
