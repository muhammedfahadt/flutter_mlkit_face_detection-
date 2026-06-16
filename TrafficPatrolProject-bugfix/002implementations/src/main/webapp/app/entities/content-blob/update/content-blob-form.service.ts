import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IContentBlob, NewContentBlob } from '../content-blob.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IContentBlob for edit and NewContentBlobFormGroupInput for create.
 */
type ContentBlobFormGroupInput = IContentBlob | PartialWithRequiredKeyOf<NewContentBlob>;

type ContentBlobFormDefaults = Pick<NewContentBlob, 'id'>;

type ContentBlobFormGroupContent = {
  id: FormControl<IContentBlob['id'] | NewContentBlob['id']>;
  contentBlob: FormControl<IContentBlob['contentBlob']>;
  contentBlobContentType: FormControl<IContentBlob['contentBlobContentType']>;
  content: FormControl<IContentBlob['content']>;
};

export type ContentBlobFormGroup = FormGroup<ContentBlobFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class ContentBlobFormService {
  createContentBlobFormGroup(contentBlob: ContentBlobFormGroupInput = { id: null }): ContentBlobFormGroup {
    const contentBlobRawValue = {
      ...this.getFormDefaults(),
      ...contentBlob,
    };
    return new FormGroup<ContentBlobFormGroupContent>({
      id: new FormControl(
        { value: contentBlobRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      contentBlob: new FormControl(contentBlobRawValue.contentBlob),
      contentBlobContentType: new FormControl(contentBlobRawValue.contentBlobContentType),
      content: new FormControl(contentBlobRawValue.content),
    });
  }

  getContentBlob(form: ContentBlobFormGroup): IContentBlob | NewContentBlob {
    return form.getRawValue() as IContentBlob | NewContentBlob;
  }

  resetForm(form: ContentBlobFormGroup, contentBlob: ContentBlobFormGroupInput): void {
    const contentBlobRawValue = { ...this.getFormDefaults(), ...contentBlob };
    form.reset(
      {
        ...contentBlobRawValue,
        id: { value: contentBlobRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): ContentBlobFormDefaults {
    return {
      id: null,
    };
  }
}
