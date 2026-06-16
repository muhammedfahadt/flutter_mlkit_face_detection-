import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { IContent, NewContent } from '../content.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IContent for edit and NewContentFormGroupInput for create.
 */
type ContentFormGroupInput = IContent | PartialWithRequiredKeyOf<NewContent>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends IContent | NewContent> = Omit<T, 'uploadDateTime'> & {
  uploadDateTime?: string | null;
};

type ContentFormRawValue = FormValueOf<IContent>;

type NewContentFormRawValue = FormValueOf<NewContent>;

type ContentFormDefaults = Pick<NewContent, 'id' | 'uploadDateTime'>;

type ContentFormGroupContent = {
  id: FormControl<ContentFormRawValue['id'] | NewContent['id']>;
  contentType: FormControl<ContentFormRawValue['contentType']>;
  uploadDateTime: FormControl<ContentFormRawValue['uploadDateTime']>;
  status: FormControl<ContentFormRawValue['status']>;
  appUser: FormControl<ContentFormRawValue['appUser']>;
};

export type ContentFormGroup = FormGroup<ContentFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class ContentFormService {
  createContentFormGroup(content: ContentFormGroupInput = { id: null }): ContentFormGroup {
    const contentRawValue = this.convertContentToContentRawValue({
      ...this.getFormDefaults(),
      ...content,
    });
    return new FormGroup<ContentFormGroupContent>({
      id: new FormControl(
        { value: contentRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      contentType: new FormControl(contentRawValue.contentType),
      uploadDateTime: new FormControl(contentRawValue.uploadDateTime),
      status: new FormControl(contentRawValue.status),
      appUser: new FormControl(contentRawValue.appUser),
    });
  }

  getContent(form: ContentFormGroup): IContent | NewContent {
    return this.convertContentRawValueToContent(form.getRawValue() as ContentFormRawValue | NewContentFormRawValue);
  }

  resetForm(form: ContentFormGroup, content: ContentFormGroupInput): void {
    const contentRawValue = this.convertContentToContentRawValue({ ...this.getFormDefaults(), ...content });
    form.reset(
      {
        ...contentRawValue,
        id: { value: contentRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): ContentFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      uploadDateTime: currentTime,
    };
  }

  private convertContentRawValueToContent(rawContent: ContentFormRawValue | NewContentFormRawValue): IContent | NewContent {
    return {
      ...rawContent,
      uploadDateTime: dayjs(rawContent.uploadDateTime, DATE_TIME_FORMAT),
    };
  }

  private convertContentToContentRawValue(
    content: IContent | (Partial<NewContent> & ContentFormDefaults),
  ): ContentFormRawValue | PartialWithRequiredKeyOf<NewContentFormRawValue> {
    return {
      ...content,
      uploadDateTime: content.uploadDateTime ? content.uploadDateTime.format(DATE_TIME_FORMAT) : undefined,
    };
  }
}
