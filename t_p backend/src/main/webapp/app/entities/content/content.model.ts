import dayjs from 'dayjs/esm';
import { IContentBlob } from 'app/entities/content-blob/content-blob.model';
import { IViolation } from 'app/entities/violation/violation.model';
import { IAppUser } from 'app/entities/app-user/app-user.model';

export interface IContent {
  id: number;
  contentType?: string | null;
  uploadDateTime?: dayjs.Dayjs | null;
  status?: string | null;
  contentBlobs?: Pick<IContentBlob, 'id'>[] | null;
  violations?: Pick<IViolation, 'id'>[] | null;
  appUser?: Pick<IAppUser, 'id'> | null;
}

export type NewContent = Omit<IContent, 'id'> & { id: null };
