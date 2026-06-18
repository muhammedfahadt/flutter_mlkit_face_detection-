import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'app-user',
    data: { pageTitle: 'trafficpatrolApp.appUser.home.title' },
    loadChildren: () => import('./app-user/app-user.routes'),
  },
  {
    path: 'content',
    data: { pageTitle: 'trafficpatrolApp.content.home.title' },
    loadChildren: () => import('./content/content.routes'),
  },
  {
    path: 'content-blob',
    data: { pageTitle: 'trafficpatrolApp.contentBlob.home.title' },
    loadChildren: () => import('./content-blob/content-blob.routes'),
  },
  {
    path: 'violation',
    data: { pageTitle: 'trafficpatrolApp.violation.home.title' },
    loadChildren: () => import('./violation/violation.routes'),
  },
  {
    path: 'points',
    data: { pageTitle: 'trafficpatrolApp.points.home.title' },
    loadChildren: () => import('./points/points.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
