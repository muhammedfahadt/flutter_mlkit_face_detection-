import { IPoints } from 'app/entities/points/points.model';
import { IAppUser } from 'app/entities/app-user/app-user.model';
import { IContent } from 'app/entities/content/content.model';

export interface IViolation {
  id: number;
  violationType?: string | null;
  points?: Pick<IPoints, 'id'> | null;
  appUser?: Pick<IAppUser, 'id'> | null;
  content?: Pick<IContent, 'id'> | null;
}

export type NewViolation = Omit<IViolation, 'id'> & { id: null };
