import { IContentBlob, NewContentBlob } from './content-blob.model';

export const sampleWithRequiredData: IContentBlob = {
  id: 18842,
};

export const sampleWithPartialData: IContentBlob = {
  id: 14879,
};

export const sampleWithFullData: IContentBlob = {
  id: 28431,
  contentBlob: '../fake-data/blob/hipster.png',
  contentBlobContentType: 'unknown',
};

export const sampleWithNewData: NewContentBlob = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
