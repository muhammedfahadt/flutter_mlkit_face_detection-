import dayjs from 'dayjs/esm';

import { IContent, NewContent } from './content.model';

export const sampleWithRequiredData: IContent = {
  id: 5941,
};

export const sampleWithPartialData: IContent = {
  id: 30083,
  contentType: 'forfeit apply',
  status: 'qualified',
};

export const sampleWithFullData: IContent = {
  id: 24852,
  contentType: 'fruitful positively',
  uploadDateTime: dayjs('2024-03-01T04:37'),
  status: 'quarrelsomely although',
};

export const sampleWithNewData: NewContent = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
