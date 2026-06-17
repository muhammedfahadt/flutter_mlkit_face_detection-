import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { IPoints, NewPoints } from '../points.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IPoints for edit and NewPointsFormGroupInput for create.
 */
type PointsFormGroupInput = IPoints | PartialWithRequiredKeyOf<NewPoints>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends IPoints | NewPoints> = Omit<T, 'uploadDateTime'> & {
  uploadDateTime?: string | null;
};

type PointsFormRawValue = FormValueOf<IPoints>;

type NewPointsFormRawValue = FormValueOf<NewPoints>;

type PointsFormDefaults = Pick<NewPoints, 'id' | 'uploadDateTime'>;

type PointsFormGroupContent = {
  id: FormControl<PointsFormRawValue['id'] | NewPoints['id']>;
  pointsEarned: FormControl<PointsFormRawValue['pointsEarned']>;
  uploadDateTime: FormControl<PointsFormRawValue['uploadDateTime']>;
  appUser: FormControl<PointsFormRawValue['appUser']>;
};

export type PointsFormGroup = FormGroup<PointsFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class PointsFormService {
  createPointsFormGroup(points: PointsFormGroupInput = { id: null }): PointsFormGroup {
    const pointsRawValue = this.convertPointsToPointsRawValue({
      ...this.getFormDefaults(),
      ...points,
    });
    return new FormGroup<PointsFormGroupContent>({
      id: new FormControl(
        { value: pointsRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      pointsEarned: new FormControl(pointsRawValue.pointsEarned),
      uploadDateTime: new FormControl(pointsRawValue.uploadDateTime),
      appUser: new FormControl(pointsRawValue.appUser),
    });
  }

  getPoints(form: PointsFormGroup): IPoints | NewPoints {
    return this.convertPointsRawValueToPoints(form.getRawValue() as PointsFormRawValue | NewPointsFormRawValue);
  }

  resetForm(form: PointsFormGroup, points: PointsFormGroupInput): void {
    const pointsRawValue = this.convertPointsToPointsRawValue({ ...this.getFormDefaults(), ...points });
    form.reset(
      {
        ...pointsRawValue,
        id: { value: pointsRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): PointsFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      uploadDateTime: currentTime,
    };
  }

  private convertPointsRawValueToPoints(rawPoints: PointsFormRawValue | NewPointsFormRawValue): IPoints | NewPoints {
    return {
      ...rawPoints,
      uploadDateTime: dayjs(rawPoints.uploadDateTime, DATE_TIME_FORMAT),
    };
  }

  private convertPointsToPointsRawValue(
    points: IPoints | (Partial<NewPoints> & PointsFormDefaults),
  ): PointsFormRawValue | PartialWithRequiredKeyOf<NewPointsFormRawValue> {
    return {
      ...points,
      uploadDateTime: points.uploadDateTime ? points.uploadDateTime.format(DATE_TIME_FORMAT) : undefined,
    };
  }
}
