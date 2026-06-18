import { IAppUser, NewAppUser } from './app-user.model';

export const sampleWithRequiredData: IAppUser = {
  id: 15799,
};

export const sampleWithPartialData: IAppUser = {
  id: 29142,
  address: 'hm pine',
  pinCode: 26908,
};

export const sampleWithFullData: IAppUser = {
  id: 2900,
  phoneNumber: '0814004533',
  address: 'that below outside',
  pinCode: 22356,
};

export const sampleWithNewData: NewAppUser = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
