import { IContent } from 'app/entities/content/content.model';

export interface IContentBlob {
  id: number;
  contentBlob?: string | null;
  contentBlobContentType?: string | null;
  content?: Pick<IContent, 'id'> | null;
}

export type NewContentBlob = Omit<IContentBlob, 'id'> & { id: null };
