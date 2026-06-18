import dayjs from 'dayjs/esm';

import { IPoints, NewPoints } from './points.model';

export const sampleWithRequiredData: IPoints = {
  id: 6180,
};

export const sampleWithPartialData: IPoints = {
  id: 21809,
  pointsEarned: 31210,
  uploadDateTime: dayjs('2024-02-29T17:22'),
};

export const sampleWithFullData: IPoints = {
  id: 11751,
  pointsEarned: 4841,
  uploadDateTime: dayjs('2024-02-29T17:08'),
};

export const sampleWithNewData: NewPoints = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
