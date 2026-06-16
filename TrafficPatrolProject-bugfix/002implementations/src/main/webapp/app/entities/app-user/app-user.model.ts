import { IUser } from 'app/entities/user/user.model';
import { IContent } from 'app/entities/content/content.model';
import { IPoints } from 'app/entities/points/points.model';
import { IViolation } from 'app/entities/violation/violation.model';

export interface IAppUser {
  id: number;
  phoneNumber?: string | null;
  address?: string | null;
  pinCode?: number | null;
  user?: Pick<IUser, 'id'> | null;
  contents?: Pick<IContent, 'id'>[] | null;
  points?: Pick<IPoints, 'id'>[] | null;
  violations?: Pick<IViolation, 'id'>[] | null;
}

export type NewAppUser = Omit<IAppUser, 'id'> & { id: null };
