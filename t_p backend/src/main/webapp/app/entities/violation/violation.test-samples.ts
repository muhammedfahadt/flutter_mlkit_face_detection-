import { IViolation, NewViolation } from './violation.model';

export const sampleWithRequiredData: IViolation = {
  id: 11130,
};

export const sampleWithPartialData: IViolation = {
  id: 4871,
};

export const sampleWithFullData: IViolation = {
  id: 18323,
  violationType: 'what yahoo unlike',
};

export const sampleWithNewData: NewViolation = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
