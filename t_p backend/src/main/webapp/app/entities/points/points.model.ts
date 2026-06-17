import dayjs from 'dayjs/esm';
import { IViolation } from 'app/entities/violation/violation.model';
import { IAppUser } from 'app/entities/app-user/app-user.model';

export interface IPoints {
  id: number;
  pointsEarned?: number | null;
  uploadDateTime?: dayjs.Dayjs | null;
  violation?: Pick<IViolation, 'id'> | null;
  appUser?: Pick<IAppUser, 'id'> | null;
}

export type NewPoints = Omit<IPoints, 'id'> & { id: null };
